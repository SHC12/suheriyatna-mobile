import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/header_widget.dart';
import 'controllers/profil.controller.dart';

class ProfilScreen extends GetView<ProfilController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            HeaderWidget(
              isBack: true,
              title: 'Profile',
              onTap: () {
                Get.to(() => ProfilScreen());
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 30.sp,
                            child: Text(
                              'DK',
                              style: defaultTextStyle.copyWith(fontSize: 16.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Dedi Kurniawan',
                          style: headTextStyle,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kode Referal', style: headTextStyle.copyWith(color: secondaryColor)),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Text('123456789',
                                      style: defaultTextStyle.copyWith(color: primaryColor, fontSize: 18.sp)),
                                  Spacer(),
                                  Icon(Icons.copy, color: primaryColor),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ganti Kata Sandi',
                              style: defaultTextStyle,
                            ),
                            Icon(Remix.arrow_right_s_line)
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tentang Aplikasi',
                              style: defaultTextStyle,
                            ),
                            Icon(Remix.arrow_right_s_line)
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Keluar',
                              style: defaultTextStyle.copyWith(color: Colors.red),
                            ),
                            Icon(Remix.arrow_right_s_line)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
