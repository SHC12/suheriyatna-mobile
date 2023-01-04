import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/custom_textfield_widget.dart';
import 'controllers/lupa_password.controller.dart';

class LupaPasswordScreen extends GetView<LupaPasswordController> {
  LupaPasswordScreen({Key? key}) : super(key: key);
  LupaPasswordController lupaPasswordController = Get.put(LupaPasswordController());
  SharedController sharedController = Get.put(SharedController());
  TextEditingController tNoHP = TextEditingController();
  TextEditingController tNIK = TextEditingController();
  TextEditingController tPassword = TextEditingController();
  TextEditingController tKonfirmasiPassword = TextEditingController();
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
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                      height: 80.h,
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
                            hintText: 'NIK',
                            iconPrefix: Remix.user_2_line,
                            tController: tNIK,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomTextfielWidget(
                            hintText: 'No HP',
                            iconPrefix: Remix.phone_line,
                            tController: tNoHP,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Obx(() => lupaPasswordController.isAvailable.value == true
                              ? Container(
                                  child: Column(
                                    children: [
                                      CustomTextfielWidget(
                                        hintText: 'Password Baru',
                                        obscureText: true,
                                        iconPrefix: Remix.lock_2_line,
                                        tController: tPassword,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      CustomTextfielWidget(
                                        hintText: 'Konfirmasi Password Baru',
                                        obscureText: true,
                                        iconPrefix: Remix.lock_2_line,
                                        tController: tKonfirmasiPassword,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  ),
                                )
                              : Container()),
                          Obx(() => ButtonWidget(
                                color: secondaryColor,
                                title: lupaPasswordController.isAvailable.value == true
                                    ? 'Konfirmasi Reset Password'
                                    : 'Reset Password',
                                onTap: () async {
                                  if (tNoHP.text.isEmpty ||
                                      tNoHP.text == null ||
                                      tNIK.text.isEmpty ||
                                      tNIK.text == null) {
                                    Get.snackbar(
                                      'Error',
                                      'No HP atau Kata Sandi tidak boleh kosong',
                                      backgroundColor: whiteColor,
                                    );
                                  } else {
                                    if (lupaPasswordController.isAvailable.value == true) {
                                      if (tPassword.text.isEmpty ||
                                          tPassword.text == null ||
                                          tKonfirmasiPassword.text.isEmpty ||
                                          tKonfirmasiPassword.text == null) {
                                        Get.snackbar(
                                          'Error',
                                          'Password atau Konfirmasi Password tidak boleh kosong',
                                          backgroundColor: whiteColor,
                                        );
                                      } else {
                                        if (tPassword.text != tKonfirmasiPassword.text) {
                                          Get.snackbar(
                                            'Error',
                                            'Password dan Konfirmasi Password tidak sama',
                                            backgroundColor: whiteColor,
                                          );
                                        } else {
                                          sharedController.loading(context);
                                          lupaPasswordController.changePassword(tPassword.text);
                                        }
                                      }
                                    } else {
                                      // sharedController.loading(context);
                                      lupaPasswordController.checkUser(tNIK.text, tNoHP.text);
                                    }
                                  }
                                },
                              )),
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
                                'Sudah memiliki akun ?',
                                style: defaultTextStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => LoginScreen());
                                },
                                child: Text(
                                  ' Login Sekarang ',
                                  style: defaultTextStyle.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
