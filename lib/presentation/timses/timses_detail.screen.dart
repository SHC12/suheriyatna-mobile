import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/relawan/controllers/relawan.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';
import 'package:suheriyatna_mobile/presentation/timses/controllers/timses.controller.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../notifikasi/notifikasi.screen.dart';

class TimsesDetailScreen extends GetView<TimsesController> {
  final Map? dataTimses;
  TimsesDetailScreen({Key? key, this.dataTimses}) : super(key: key);

  SharedController sharedController = Get.put(SharedController());
  TimsesController timsesController = Get.put(TimsesController());
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
    Timestamp t = dataTimses!['created_at'];
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
                      Text('Detail Timses', style: headTextStyle.copyWith(color: whiteColor)),
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
                    'Data Timses',
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
                                      dataTimses!['nik'],
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
                                      dataTimses!['nama_lengkap'],
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
                                      dataTimses!['no_telp'] ?? '',
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Jenis Kelamin',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['jenis_kelamin'] ?? '',
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Tempat Lahir',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['tempat_lahir'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Tanggal Lahir',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['tanggal_lahir'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Kabupaten',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['kabupaten'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Kecamatan',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['kecamatan'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Kelurahan',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['kelurahan'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Alamat',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['alamat'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'RT/RW',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['rt'] + '/' + dataTimses!['rw'],
                                      textAlign: TextAlign.left,
                                      style: defaultTextStyle,
                                    ),
                                  ]),
                                  rowSpacer,
                                  TableRow(children: [
                                    Text(
                                      'Tanggal Pendaftaran',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      ':',
                                      style: defaultPrimaryTextStyle,
                                    ),
                                    Text(
                                      dataTimses!['created_at'] == null
                                          ? ''
                                          : DateFormat('dd-MM-yyyy').format(DateTime.parse(t.toDate().toString())),
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
                                      dataTimses!['wilayah_kerja'],
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
                    title: 'Nonaktifkan Timses',
                    onTap: () {
                      sharedController
                          .popUpMessage('Konfirmasi', 'Apakah Anda yakin ingin nonaktifkan timses?', 'Batal', 'Ya', () {
                        Get.back();
                        sharedController.loading(context);
                        timsesController.nonAktifkanTimses(dataTimses!['nik']);
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
