import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/relawan/controllers/relawan.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../notifikasi/notifikasi.screen.dart';
import '../shared/widget/button_widget.dart';

class RelawanDetailScreen extends StatefulWidget {
  final Map? dataRelawan;

  const RelawanDetailScreen({Key? key, this.dataRelawan}) : super(key: key);

  @override
  State<RelawanDetailScreen> createState() => _RelawanDetailScreenState();
}

class _RelawanDetailScreenState extends State<RelawanDetailScreen> {
  RelawanController relawanController = Get.put(RelawanController());

  SharedController sharedController = Get.put(SharedController());
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
  void initState() {
    // TODO: implement initState
    super.initState();

    relawanController.getReferral(widget.dataRelawan!['nik_referral']);
  }

  @override
  Widget build(BuildContext context) {
    Timestamp t = widget.dataRelawan!['created_at'];
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
                      Text('Detail Relawan', style: headTextStyle.copyWith(color: whiteColor)),
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
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Relawan',
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
                                        'Nama Referral',
                                        style: defaultPrimaryTextStyle,
                                      ),
                                      Text(
                                        ':',
                                        style: defaultPrimaryTextStyle,
                                      ),
                                      Text(
                                        relawanController.nameReferral.toString(),
                                        textAlign: TextAlign.left,
                                        style: defaultTextStyle,
                                      ),
                                    ]),
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
                                        widget.dataRelawan!['nik'],
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
                                        widget.dataRelawan!['nama_lengkap'],
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
                                        widget.dataRelawan!['no_telp'] ?? '',
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
                                        widget.dataRelawan!['jenis_kelamin'],
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
                                        widget.dataRelawan!['tempat_lahir'],
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
                                        widget.dataRelawan!['tanggal_lahir'],
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
                                        widget.dataRelawan!['kabupaten'],
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
                                        widget.dataRelawan!['kecamatan'],
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
                                        widget.dataRelawan!['kelurahan'],
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
                                        widget.dataRelawan!['alamat'],
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
                                        widget.dataRelawan!['rt'] + '/' + widget.dataRelawan!['rw'],
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
                                        widget.dataRelawan!['created_at'] == null
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
                                        widget.dataRelawan!['wilayah_kerja'],
                                        textAlign: TextAlign.left,
                                        style: defaultTextStyle,
                                      ),
                                    ]),
                                    rowSpacer,
                                    TableRow(children: [
                                      Text(
                                        'TPS',
                                        style: defaultPrimaryTextStyle,
                                      ),
                                      Text(
                                        ':',
                                        style: defaultPrimaryTextStyle,
                                      ),
                                      Text(
                                        widget.dataRelawan!['tps'] == null ? '' : widget.dataRelawan!['tps'],
                                        textAlign: TextAlign.left,
                                        style: defaultTextStyle,
                                      ),
                                    ]),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Dokumen Pendukung',
                                  style: defaultPrimaryTextStyle,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Image.network(widget.dataRelawan!['file_pendukung']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: prefs.read('role') == '0' || prefs.read('role') == '00' ? true : false,
                      child: ButtonWidget(
                        color: Colors.red,
                        title: 'Hapus Relawan',
                        onTap: () {
                          sharedController.popUpMessage(
                              'Konfirmasi', 'Apakah Anda yakin ingin menghapus relawan?', 'Batal', 'Ya', () {
                            Get.back();
                            sharedController.loading(context);
                            relawanController.nonAktifRelawan(widget.dataRelawan!['nik']);
                          }, true, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
