import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/cek_data/controllers/cek_data.controller.dart';
import 'package:suheriyatna_mobile/presentation/relawan/controllers/relawan.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/chart/kuisioner.chart.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/chart/timses.chart.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';
import '../../../main.dart';
import '../../kuisioner/kuisioner_detail.screen.dart';
import '../../shared/widget/dropdown_field_widget.dart';
import '../../timses/controllers/timses.controller.dart';
import '../../timses/timses_detail.screen.dart';
import '../controllers/summary_data.controller.dart';

class KuisionerTabbar extends StatefulWidget {
  const KuisionerTabbar({Key? key}) : super(key: key);

  @override
  State<KuisionerTabbar> createState() => _KuisionerTabbarState();
}

class _KuisionerTabbarState extends State<KuisionerTabbar> {
  SummaryDataController summaryDataController = Get.put(SummaryDataController());
  SharedController sharedController = Get.put(SharedController());
  KuisionerTabbar cekDataController = Get.put(KuisionerTabbar());

  bool isChart = false;

  String? kabupatenValue;
  String? kabupatenString;
  var kecamatanValue;
  var kecamatanStringValue;
  var kelurahanStringValue;
  var kelurahanValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sharedController.fetchKabupaten();
    summaryDataController.getTotalDataTimses();
    summaryDataController.getTotalDataRelawan();
    summaryDataController.getTotalDataKuisioner();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: orangeColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Timses',
                                      style: defaultPrimaryTextStyle.copyWith(color: whiteColor, fontSize: 10.sp)),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(summaryDataController.totalDataKuisioner.value.toString(),
                                      style: headTextStyle.copyWith(
                                          color: whiteColor, fontWeight: FontWeight.bold, fontSize: 19.sp)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35.w,
                  child: ButtonWidget(
                    color: Colors.green,
                    title: 'Export Excel',
                    onTap: () {
                      sharedController.exportExcelKuisioner(summaryDataController.dataKuisioner.value, 'Kuisioner');
                    },
                  ),
                ),
                Container(
                  width: 35.w,
                  child: ButtonWidget(
                    color: primaryColor,
                    title: isChart == false ? 'Chart' : 'Datatable',
                    onTap: () {
                      if (isChart == true) {
                        setState(() {
                          isChart = false;
                        });
                      } else {
                        setState(() {
                          isChart = true;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              child: isChart == false
                  ? Obx(() => FittedBox(
                          child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith((states) => primaryColor),
                        columns: [
                          DataColumn(
                              label: Text(
                            'Action',
                            style: whiteTextStyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Nama Lengkap',
                            style: whiteTextStyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Tanggal Kuisioner',
                            style: whiteTextStyle,
                          )),
                        ],
                        rows: summaryDataController.dataKuisioner.value.map((e) {
                          Timestamp t = e!['created_at'];
                          return DataRow(cells: [
                            DataCell(GestureDetector(
                              onTap: () async {
                                if (prefs.read('role') == '0') {
                                  Get.to(() => KuisionerDetailScreen(
                                        dataKuisioner: e,
                                      ));
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.4.h),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Remix.eye_line,
                                  color: whiteColor,
                                ),
                              ),
                            )),
                            DataCell(Text(
                              e['nama_kuisioner'] ?? '',
                              style: defaultPrimaryTextStyle,
                            )),
                            DataCell(Text(
                              DateFormat('dd-MM-yyyy').format(DateTime.parse(t.toDate().toString())),
                              style: defaultPrimaryTextStyle,
                            )),
                          ]);
                        }).toList(),
                      )))
                  : Container(
                      child: Column(
                        children: [KuisionerChart()],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
