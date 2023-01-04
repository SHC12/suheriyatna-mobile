import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_detail.screen.dart';
import 'package:suheriyatna_mobile/presentation/relawan/relawan_detail.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/header_widget.dart';
import 'controllers/cek_data.controller.dart';

class CekDataScreen extends GetView<CekDataController> {
  CekDataController cekDataController = Get.put(CekDataController());
  CekDataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(
            isBack: true,
            isHome: false,
            title: 'Cek Data',
            onTap: () {},
          ),
          Obx(() => Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FittedBox(
                child: prefs.read('role') == '0'
                    ? DataTable(
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
                        rows: cekDataController.dataList.value.map((e) {
                          return DataRow(cells: [
                            DataCell(GestureDetector(
                              onTap: () async {
                                if (prefs.read('role') == '0') {
                                  Get.to(() => RelawanDetailScreen(
                                        dataRelawan: e,
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
                              e['nik'] ?? '',
                              style: greyTextStyle,
                            )),
                            DataCell(Text(
                              e['nama_lengkap'] ?? '',
                              style: defaultPrimaryTextStyle,
                            )),
                          ]);
                        }).toList(),
                      )
                    : prefs.read('role') == '1'
                        ? DataTable(
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
                            rows: cekDataController.dataList.value.map((e) {
                              return DataRow(cells: [
                                DataCell(GestureDetector(
                                  onTap: () async {
                                    if (prefs.read('role') == '1') {
                                      Get.to(() => RelawanDetailScreen(
                                            dataRelawan: e,
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
                                  e['nik'],
                                  style: greyTextStyle,
                                )),
                                DataCell(Text(
                                  e['nama_lengkap'],
                                  style: defaultPrimaryTextStyle,
                                )),
                              ]);
                            }).toList(),
                          )
                        : DataTable(
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
                            rows: cekDataController.dataList.value.map((e) {
                              Timestamp t = e!['created_at'];
                              return DataRow(cells: [
                                DataCell(GestureDetector(
                                  onTap: () async {
                                    if (prefs.read('role') == '2') {
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
                                  e['nama_kuisioner'],
                                  style: defaultPrimaryTextStyle,
                                )),
                                DataCell(Text(
                                  DateFormat('dd-MM-yyyy').format(DateTime.parse(t.toDate().toString())),
                                  style: defaultPrimaryTextStyle,
                                )),
                              ]);
                            }).toList(),
                          ),
              )))
        ],
      ),
    ));
  }
}
