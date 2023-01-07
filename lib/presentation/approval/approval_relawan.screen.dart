import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/dropdown_field_widget.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/button_widget.dart';
import 'controllers/approval.controller.dart';

class ApprovalRelawanScreen extends StatefulWidget {
  const ApprovalRelawanScreen({Key? key}) : super(key: key);

  @override
  State<ApprovalRelawanScreen> createState() => _ApprovalRelawanScreenState();
}

class _ApprovalRelawanScreenState extends State<ApprovalRelawanScreen> {
  ApprovalController approvalController = Get.put(ApprovalController());
  SharedController sharedController = Get.put(SharedController());

  String? kabupatenValue;
  String? kabupatenString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedController.fetchKabupaten();
    approvalController.getDataRelawan();
  }

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
                  Obx(() => Container(
                        width: double.infinity,
                        child: DropdownFieldWidget(
                          title: 'Kabupaten',
                          listValue: sharedController.kabupatenList.value,
                          value: kabupatenValue,
                          isRequired: true,
                          listName: 'name',
                          valueName: 'id',
                          itemCallback: (String value) {
                            kabupatenValue = value;
                            var wilayahKerjaempValue = sharedController.kabupatenList.value
                                .where((element) => element['id'] == value)
                                .toList();

                            kabupatenString = wilayahKerjaempValue[0]['name'];
                            approvalController.getDataRelawanByKabupaten(kabupatenString);
                          },
                        ),
                      )),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ButtonWidget(
                        color: secondaryColor,
                        title: 'Approve Semua Relawan',
                        onTap: () {
                          approvalController.approveAllRelawan(context, kabupatenString);
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
                          rows: approvalController.dataList.value.map((e) {
                            return DataRow(cells: [
                              DataCell(GestureDetector(
                                onTap: () async {
                                  approvalController.approveRelawan(e['id'], kabupatenString);
                                  print(e['id']);
                                  print(kabupatenString);
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
