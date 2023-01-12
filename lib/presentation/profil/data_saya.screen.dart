import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/profil/controllers/profil.controller.dart';
import 'package:suheriyatna_mobile/presentation/profil/profil.screen.dart';
import 'package:suheriyatna_mobile/presentation/profil/update_data.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/controllers/shared.controller.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/header_widget.dart';

class DataSayaScreen extends StatefulWidget {
  final List? dataSaya;
  const DataSayaScreen({Key? key, this.dataSaya}) : super(key: key);

  @override
  State<DataSayaScreen> createState() => _DataSayaScreenState();
}

class _DataSayaScreenState extends State<DataSayaScreen> {
  ProfilController profilController = Get.put(ProfilController());
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
  Widget build(BuildContext context) {
    Timestamp t = widget.dataSaya![0]['created_at'];
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          HeaderWidget(
            isHome: false,
            title: 'Data Saya',
            isBack: true,
            onTap: () {
              Get.to(() => ProfilScreen());
            },
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
                  'Detail Data',
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
                                    widget.dataSaya![0]['nik'],
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
                                    widget.dataSaya![0]['nama_lengkap'],
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
                                    widget.dataSaya![0]['no_telp'] ?? '',
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
                                    widget.dataSaya![0]['jenis_kelamin'] ?? '',
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
                                    widget.dataSaya![0]['tempat_lahir'],
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
                                    widget.dataSaya![0]['tanggal_lahir'],
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
                                    widget.dataSaya![0]['kabupaten'],
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
                                    widget.dataSaya![0]['kecamatan'],
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
                                    widget.dataSaya![0]['kelurahan'],
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
                                    widget.dataSaya![0]['alamat'],
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
                                    widget.dataSaya![0]['rt'] + '/' + widget.dataSaya![0]['rw'],
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
                                    widget.dataSaya![0]['created_at'] == null
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
                                    widget.dataSaya![0]['wilayah_kerja'],
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
                  color: secondaryColor,
                  title: 'Ubah Data',
                  onTap: () {
                    profilController.toUpdateScreen();
                  },
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
