// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/login/verifikasi_otp.screen.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../home/home.screen.dart';
import '../registration/registration.screen.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/custom_textfield_widget.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  TextEditingController tNoHP = TextEditingController();
  TextEditingController tKataSandi = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(
                        child: Image.asset(
                      'assets/images/main_logo_transparent.png',
                      width: 35.w,
                    )),
                  ),
                  flex: 1,
                ),
                Flexible(
                  // ignore: sort_child_properties_last
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Selamat Datang di',
                                style: defaultPrimaryTextStyle.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Suheriyatna Mobile !',
                                style: defaultPrimaryTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextfielWidget(
                          hintText: 'No HP',
                          iconPrefix: Remix.phone_line,
                          tController: tNoHP,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomTextfielWidget(
                          hintText: 'Password',
                          obscureText: true,
                          iconPrefix: Remix.lock_2_line,
                          tController: tKataSandi,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ButtonWidget(
                          color: secondaryColor,
                          title: 'Login',
                          onTap: () async {
                            if (tNoHP.text.isEmpty ||
                                tNoHP.text == null ||
                                tKataSandi.text.isEmpty ||
                                tKataSandi.text == null) {
                              Get.snackbar(
                                'Error',
                                'No HP atau Kata Sandi tidak boleh kosong',
                                backgroundColor: whiteColor,
                              );
                            } else {
                              loginController.login(tNoHP.text, tKataSandi.text, context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => LupaPasswordScreen());
                              },
                              child: Text(
                                'Lupa Password ?',
                                style: defaultTextStyle.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
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
                                Get.to(() => RegistrationScreen());
                              },
                              child: Text(
                                ' Daftar Sekarang ',
                                style: defaultTextStyle.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  flex: 2,
                ),
              ],
            ),
          ),
        ));
  }
}
