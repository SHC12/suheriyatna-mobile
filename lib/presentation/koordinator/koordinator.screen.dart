import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/add_koordinator.screen.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/controllers/koordinator.controller.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/detail_koordinator.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/dropdown_field_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/header_widget.dart';
import 'package:suheriyatna_mobile/presentation/timses/timses_detail.screen.dart';

class KoordinatorScreen extends StatefulWidget {
  const KoordinatorScreen({Key? key}) : super(key: key);

  @override
  State<KoordinatorScreen> createState() => _KoordinatorScreenState();
}

class _KoordinatorScreenState extends State<KoordinatorScreen> {
  KoordinatorController koordinatorController = Get.put(KoordinatorController());
  SharedController sharedController = Get.put(SharedController());

  String? kabupatenValue;
  String? kabupatenString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(() => AddKoordinatorScreen());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderWidget(
                isBack: true,
                title: 'Koordinator Timses',
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Column(children: [
                        Obx(() => Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: DropdownFieldWidget(
                                    title: 'Wilayah Kerja',
                                    listValue: sharedController.kabupatenList.value,
                                    value: kabupatenValue,
                                    listName: 'name',
                                    valueName: 'id',
                                    itemCallback: (String value) {
                                      kabupatenValue = value;
                                      sharedController.fetchKecamatan(value);
                                      var wilayahKerjaempValue = sharedController.kabupatenList.value
                                          .where((element) => element['id'] == value)
                                          .toList();

                                      kabupatenString = wilayahKerjaempValue[0]['name'];

                                      koordinatorController.getDataKoordinatorByKabupaten(kabupatenString);
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ]),
                      SizedBox(
                        height: 1.h,
                      ),
                      FittedBox(
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
                        rows: koordinatorController.dataList.value.map((e) {
                          return DataRow(cells: [
                            DataCell(GestureDetector(
                              onTap: () async {
                                Get.to(() => KoordinatorDetailScreen(
                                      dataKoordinator: e,
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
                              e['nik'].toString(),
                              style: greyTextStyle,
                            )),
                            DataCell(Text(
                              e['nama_lengkap'] ?? '',
                              style: defaultPrimaryTextStyle,
                            )),
                          ]);
                        }).toList(),
                      )),
                    ],
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
