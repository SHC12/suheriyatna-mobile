import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/approval/controllers/approval.controller.dart';
import 'package:suheriyatna_mobile/presentation/home/widget/main_icon_widget.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/koordinator.screen.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_add.screen.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_list.screen.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/controllers/pengumuman.controller.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/pengumuman_list.screen.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/widget/card_pengumuman.widget.dart';
import 'package:suheriyatna_mobile/presentation/relawan/relawan_list.screen.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../approval/approval_relawan.screen.dart';
import '../pengumuman/pengumuman_detail.screen.dart';
import '../shared/widget/header_widget.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  ApprovalController approvalController = Get.put(ApprovalController());
  PengumumanController pengumumanController = Get.put(PengumumanController());
  SharedController sharedController = Get.put(SharedController());
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
                  child: prefs.read('role') == '0' || prefs.read('role') == '00'
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
                                    title: 'Approval Timses',
                                    onTap: () {
                                      Get.to(() => ApprovalScreen());
                                    },
                                  ),
                                  MainIconWidget(
                                    icon: Remix.check_line,
                                    title: 'Approval Relawan',
                                    onTap: () {
                                      Get.to(() => ApprovalRelawanScreen());
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
                                    icon: Remix.user_star_line,
                                    title: 'Timses',
                                    onTap: () {
                                      Get.to(() => TimsesScreen());
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
                                    icon: Remix.user_location_line,
                                    title: 'Koordinator',
                                    onTap: () {
                                      if (prefs.read('role') == '00') {
                                        sharedController.popUpMessage(
                                            'Gagal',
                                            'Anda tidak memiliki akses untuk fitur ini',
                                            '',
                                            '',
                                            () => null,
                                            false,
                                            context);
                                      } else {
                                        Get.to(() => KoordinatorScreen());
                                      }
                                    },
                                  ),
                                  MainIconWidget(
                                    icon: Remix.survey_line,
                                    title: 'Kuisioner',
                                    onTap: () {
                                      Get.to(() => KuisionerListScreen());
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
                                    icon: Remix.line_chart_line,
                                    title: 'Summary Data',
                                    onTap: () {
                                      Get.to(() => SummaryDataScreen());
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
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainIconWidget(
                                    icon: Remix.information_line,
                                    title: 'Pengumuman',
                                    onTap: () {
                                      Get.to(() => PengumumanListScreen());
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
                              Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Obx(() => Container(
                                        child: Row(
                                          children: pengumumanController.pengumumanList.map((element) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(() => PengumumanDetailScreen(
                                                      dataPengumuman: element,
                                                    ));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(right: 4.w),
                                                height: 25.h,
                                                width: 80.w,
                                                child: CardPengumumanWidget(
                                                  title: element['judul'],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )),
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
