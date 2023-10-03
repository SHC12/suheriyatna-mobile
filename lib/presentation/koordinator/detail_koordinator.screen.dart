import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/controllers/koordinator.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';
import 'package:suheriyatna_mobile/presentation/timses/controllers/timses.controller.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../notifikasi/notifikasi.screen.dart';

class KoordinatorDetailScreen extends GetView<TimsesController> {
  final Map? dataKoordinator;
  KoordinatorDetailScreen({Key? key, this.dataKoordinator}) : super(key: key);

  SharedController sharedController = Get.put(SharedController());
  KoordinatorController koordinatorController = Get.put(KoordinatorController());
  static const rowSpacer = TableRow(children: [
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    )
  ]);

  @override
  Widget build(BuildContext context) {
    Timestamp t = dataKoordinator!['created_at'];
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
                      Text('Detail Koordinator', style: headTextStyle.copyWith(color: whiteColor)),
                      GestureDetector(
                        onTap: () => Get.to(() => NotifikasiScreen()),
                        child: Icon(
                          Remix.notification_3_line,
                          color: whiteColor,
                        ),
                      )
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
                  Text(
                    'Data Koordinator',
                    style: defaultPrimaryTextStyle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    margin: EdgeInsets.only(bottom: 2.h),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0.0, 0.0),
                      )
                    ], color: whiteColor, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                columnWidths: {
                                  0: FlexColumnWidth(6.w),
                                  1: FlexColumnWidth(1.w),
                                  2: FlexColumnWidth(10.w),
                                },
                                children: [
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'NIK',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataKoordinator!['nik'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Nama Lengkap',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataKoordinator!['nama_lengkap'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'No. Telp',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataKoordinator!['no_telp'] ?? '',
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Wilayah Kerja',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataKoordinator!['wilayah_kerja'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonWidget(
                    color: Colors.red,
                    title: 'Hapus Koordinator',
                    onTap: () {
                      sharedController
                          .popUpMessage('Konfirmasi', 'Apakah Anda yakin ingin hapus koordinator?', 'Batal', 'Ya', () {
                        Get.back();
                        sharedController.loading(context);
                        koordinatorController.nonAktifkanKoordinator(dataKoordinator!['nik']);
                      }, true, context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
