import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/input_field_widget.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/chart/timses.chart.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';
import '../../shared/widget/dropdown_field_widget.dart';
import '../../timses/controllers/timses.controller.dart';
import '../../timses/timses_detail.screen.dart';
import '../controllers/summary_data.controller.dart';

class TimsesTabbar extends StatefulWidget {
  const TimsesTabbar({Key? key}) : super(key: key);

  @override
  State<TimsesTabbar> createState() => _TimsesTabbarState();
}

class _TimsesTabbarState extends State<TimsesTabbar> {
  SummaryDataController summaryDataController = Get.put(SummaryDataController());
  SharedController sharedController = Get.put(SharedController());
  TimsesController timsesController = Get.put(TimsesController());

  TextEditingController tSearch = TextEditingController();

  String? kabupatenValue;
  String? kabupatenString;
  var kecamatanValue;
  var kecamatanStringValue;
  var kelurahanStringValue;
  var kelurahanValue;

  bool isChart = false;
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
                                  Text(timsesController.totalTimsesSelected.value.toString(),
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
            Obx(() => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: DropdownFieldWidget(
                        title: 'Kabupaten',
                        listValue: sharedController.kabupatenList.value,
                        value: kabupatenValue,
                        listName: 'name',
                        valueName: 'id',
                        itemCallback: (String value) async {
                          kabupatenValue = value;
                          await sharedController.fetchKecamatan(value);
                          var wilayahKerjaempValue =
                              sharedController.kabupatenList.value.where((element) => element['id'] == value).toList();

                          kabupatenString = wilayahKerjaempValue[0]['name'];

                          await timsesController.getDataTimsesByKabupaten(kabupatenString);
                          await summaryDataController.dataChartKecamatan(kabupatenString);
                          kecamatanValue = null;
                          kelurahanValue = null;
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: DropdownFieldWidget(
                              title: 'Kecamatan',
                              listValue: sharedController.kecamatanList.value,
                              value: kecamatanValue,
                              listName: 'name',
                              valueName: 'id',
                              itemCallback: (String value) async {
                                kecamatanValue = value;
                                await sharedController.fetchKelurahan(value);

                                var kecamatanTempValue = sharedController.kecamatanList.value
                                    .where((element) => element['id'] == value)
                                    .toList();

                                kecamatanStringValue = kecamatanTempValue[0]['name'];
                                await timsesController.getDataTimsesByKecamatan(kecamatanStringValue);
                                await summaryDataController.dataChartKelurahan(kecamatanStringValue);
                                kelurahanValue = null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownFieldWidget(
                              title: 'Kelurahan',
                              listValue: sharedController.kelurahanList.value,
                              value: kelurahanValue,
                              listName: 'name',
                              valueName: 'id',
                              itemCallback: (String value) {
                                kelurahanValue = value;
                                var kelurahanTempValue = sharedController.kelurahanList.value
                                    .where((element) => element['id'] == value)
                                    .toList();

                                kelurahanStringValue = kelurahanTempValue[0]['name'];
                                timsesController.getDataTimsesByKelurahan(kelurahanStringValue);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
                      sharedController.exportExcel(timsesController.dataList.value, 'Timses');
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
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 60.w,
                  child: InputFieldWidget(
                    tController: tSearch,
                    title: 'Cari Timses',
                    hint: 'Silahkan Masukkan Nama Lengkap',
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 30.w,
                  child: ButtonWidget(
                    color: primaryColor,
                    title: 'Cari',
                    onTap: () {
                      timsesController.searchTimsesByName(tSearch.text);
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
                            'NIK',
                            style: whiteTextStyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Nama Lengkap',
                            style: whiteTextStyle,
                          )),
                        ],
                        rows: timsesController.dataList.value.map((e) {
                          return DataRow(cells: [
                            DataCell(GestureDetector(
                              onTap: () async {
                                Get.to(() => TimsesDetailScreen(
                                      dataTimses: e,
                                    ));
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
                              e['nik'] ?? '',
                              style: greyTextStyle,
                            )),
                            DataCell(Text(
                              e['nama_lengkap'] ?? '',
                              style: defaultPrimaryTextStyle,
                            )),
                          ]);
                        }).toList(),
                      )))
                  : Container(
                      child: Column(
                        children: [TimsesChart()],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
