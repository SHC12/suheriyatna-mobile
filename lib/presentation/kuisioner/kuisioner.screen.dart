import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_add.screen.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_detail.screen.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/widget/card_list_relawan.widget.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../notifikasi/notifikasi.screen.dart';
import '../relawan/widget/card_list_relawan.widget.dart';
import 'controllers/kuisioner.controller.dart';

class KuisionerScreen extends GetView<KuisionerController> {
  KuisionerController kuisionerController = Get.put(KuisionerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Get.to(() => KuisionerAddScreen());
          },
          child: Icon(Remix.user_add_fill),
        ),
        body: SingleChildScrollView(
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
                        Text('Kuisioner', style: headTextStyle.copyWith(color: whiteColor)),
                        GestureDetector(
                          onTap: () => Get.to(() => NotifikasiScreen()),
                          child: Icon(
                            Remix.notification_3_line,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Column(
                    children: kuisionerController.dataKuisioner.value.map((e) {
                      Timestamp t = e['created_at'];
                      return CardListKuisionerWidget(
                        onTap: () {
                          Get.to(() => KuisionerDetailScreen(
                                dataKuisioner: e,
                              ));
                        },
                        title: e['nama_kuisioner'],
                      );
                    }).toList(),
                  )))
            ],
          ),
        ));
  }
}
