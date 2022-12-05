// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../home/home.screen.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/custom_textfield_widget.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Halo, Sobat Bang Yatna',
                style: headTextStyle.copyWith(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 14.sp)),
            SizedBox(height: 2.h),
            Container(
              height: 60.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: headTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold, color: secondaryColor),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextfielWidget(
                    hintText: 'No HP',
                    iconPrefix: Remix.phone_line,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextfielWidget(
                    hintText: 'Password',
                    iconPrefix: Remix.lock_line,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ButtonWidget(
                    color: secondaryColor,
                    title: 'Login',
                    onTap: () {
                      Get.offAll(() => HomeScreen());
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Divider(
                            thickness: 2,
                          )),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        ' atau ',
                        style: defaultTextStyle,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Flexible(
                          flex: 1,
                          child: Divider(
                            thickness: 2,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum memiliki akun ?',
                        style: defaultTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(RegistrationScreen());
                        },
                        child: Text(
                          ' Daftar Sekarang ',
                          style: defaultTextStyle.copyWith(color: mainColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
