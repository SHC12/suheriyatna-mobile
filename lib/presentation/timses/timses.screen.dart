import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_detail.screen.dart';
import 'package:suheriyatna_mobile/presentation/relawan/relawan_detail.screen.dart';
import 'package:suheriyatna_mobile/presentation/timses/controllers/timses.controller.dart';
import 'package:suheriyatna_mobile/presentation/timses/timses_detail.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/header_widget.dart';

class TimsesScreen extends GetView<TimsesController> {
  TimsesController timsesController = Get.put(TimsesController());
  TimsesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(
            isBack: true,
            isHome: false,
            title: 'Data Timses',
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
              ))))
        ],
      ),
    ));
  }
}
