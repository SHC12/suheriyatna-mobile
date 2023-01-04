import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/button_widget.dart';
import 'controllers/approval.controller.dart';

class ApprovalScreen extends GetView<ApprovalController> {
  ApprovalScreen({Key? key}) : super(key: key);
  ApprovalController approvalController = Get.put(ApprovalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Remix.arrow_left_line, color: whiteColor),
                      ),
                      Text('Approval Relawan', style: headTextStyle.copyWith(color: whiteColor)),
                      Container()
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ButtonWidget(
                        color: secondaryColor,
                        title: 'Approve Semua User',
                        onTap: () {
                          approvalController.approveAllUser(context);
                        }),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Obx(() => FittedBox(
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith((states) => primaryColor),
                          columns: [
                            DataColumn(
                                label: Text(
                              'Approve',
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
                          rows: approvalController.userUnverifiedList.value.map((e) {
                            return DataRow(cells: [
                              DataCell(GestureDetector(
                                onTap: () async {
                                  approvalController.approveUser(e['id']);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.4.h),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Remix.check_line,
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
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
