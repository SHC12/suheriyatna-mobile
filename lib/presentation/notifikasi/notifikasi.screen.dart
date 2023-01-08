import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/notifikasi/widget/notifikasi_card_widget.dart';

import '../shared/widget/header_widget.dart';
import 'controllers/notifikasi.controller.dart';

class NotifikasiScreen extends GetView<NotifikasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
            top: false,
            child: Column(
              children: [
                HeaderWidget(
                  isBack: true,
                  title: 'Notifikasi',
                ),
                SizedBox(
                  height: 2.h,
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                //   child: Column(
                //     children: [
                //       NotifikasiCardWidget(
                //           title: 'Informasi',
                //           subtitle: 'Terdapat relawan baru dengan referal Anda',
                //           date: '18 Okt 2022 16.00'),
                //     ],
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}
