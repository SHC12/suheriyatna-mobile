import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/approval/controllers/approval.controller.dart';
import 'package:suheriyatna_mobile/presentation/home/widget/main_icon_widget.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_add.screen.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_list.screen.dart';
import 'package:suheriyatna_mobile/presentation/relawan/relawan_list.screen.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/header_widget.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  ApprovalController approvalController = Get.put(ApprovalController());
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  isHome: true,
                  title: 'Suheriyatna Mobile',
                  onTap: () {
                    Get.to(() => ProfilScreen());
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  child: prefs.read('role') == '0'
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainIconWidget(
                                    icon: Remix.check_double_line,
                                    title: 'Approval',
                                    onTap: () {
                                      Get.to(() => ApprovalScreen());
                                    },
                                  ),
                                  MainIconWidget(
                                    icon: Remix.group_line,
                                    title: 'Relawan',
                                    onTap: () {
                                      Get.to(() => CekDataScreen());
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainIconWidget(
                                    icon: Remix.survey_line,
                                    title: 'Kuisioner',
                                    onTap: () {
                                      Get.to(() => KuisionerListScreen());
                                    },
                                  ),
                                  MainIconWidget(
                                    icon: Remix.chat_poll_line,
                                    title: 'Quick Count',
                                    onTap: () {
                                      FToast.toast(context, msg: "Segera Hadir");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              Visibility(
                                visible: prefs.read('role') == '1' ? true : false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MainIconWidget(
                                      icon: Remix.group_line,
                                      title: 'Relawan',
                                      onTap: () {
                                        Get.to(RelawanScreen());
                                      },
                                    ),
                                    MainIconWidget(
                                      icon: Remix.search_eye_line,
                                      title: 'Cek Data',
                                      onTap: () {
                                        Get.to(() => CekDataScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: prefs.read('role') == '2' ? true : false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MainIconWidget(
                                      icon: Remix.add_circle_line,
                                      title: 'Kuisioner',
                                      onTap: () {
                                        Get.to(() => KuisionerAddScreen());
                                      },
                                    ),
                                    MainIconWidget(
                                      icon: Remix.search_eye_line,
                                      title: 'Cek Data',
                                      onTap: () {
                                        Get.to(() => CekDataScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: prefs.read('role') == '3' ? true : false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MainIconWidget(
                                      icon: Remix.file_chart_line,
                                      title: 'Real Count',
                                      onTap: () {
                                        FToast.toast(context, msg: "Segera Hadir");
                                      },
                                    ),
                                    MainIconWidget(
                                      icon: Remix.search_eye_line,
                                      title: 'Cek Data',
                                      onTap: () {
                                        FToast.toast(context, msg: "Segera Hadir");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainIconWidget(
                                    icon: Remix.notification_3_line,
                                    title: 'Notifikasi',
                                    onTap: () {
                                      Get.to(() => NotifikasiScreen());
                                    },
                                  ),
                                  MainIconWidget(
                                    icon: Remix.customer_service_2_line,
                                    title: 'Info Hotline',
                                    onTap: () {
                                      Get.to(() => HotlineScreen());
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                'Update Info Timses',
                                style: defaultTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Yuk lihat update terbaru disini',
                                style: defaultTextStyle.copyWith(fontSize: 14.sp, color: greyColor),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 3.w),
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.asset('assets/images/banner2.jpg', fit: BoxFit.cover)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  'Contoh judul artikel 1',
                                                  style: defaultTextStyle.copyWith(
                                                      fontSize: 10.sp, fontWeight: FontWeight.bold),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(vertical: 1.h),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 2.w),
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.asset('assets/images/banner1.jpg', fit: BoxFit.cover)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  'Contoh judul artikel 2',
                                                  style: defaultTextStyle.copyWith(
                                                      fontSize: 10.sp, fontWeight: FontWeight.bold),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(vertical: 1.h),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            )),
      ),
    );
  }
}
