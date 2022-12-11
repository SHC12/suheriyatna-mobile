import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/relawan/controllers/relawan.controller.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../notifikasi/notifikasi.screen.dart';

class RelawanListScreen extends GetView<RelawanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(RelawanScreen());
        },
        child: Icon(Remix.user_add_fill),
      ),
      body: Container(
        child: Column(
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
                      Text('Daftar Relawan', style: headTextStyle.copyWith(color: whiteColor)),
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
          ],
        ),
      ),
    );
  }
}
