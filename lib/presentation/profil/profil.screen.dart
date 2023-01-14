import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/input_field_widget.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../pengumuman/pengumuman.screen.dart';
import '../shared/widget/header_widget.dart';
import 'controllers/profil.controller.dart';

class ProfilScreen extends GetView<ProfilController> {
  SharedController sharedController = Get.put(SharedController());
  ProfilController profilController = Get.put(ProfilController());

  TextEditingController tPassword = TextEditingController();
  TextEditingController tKonfirmasiPassword = TextEditingController();

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
                              sharedController.getInitials(prefs.read('namaLengkap')),
                              style: defaultTextStyle.copyWith(fontSize: 16.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          prefs.read('namaLengkap'),
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
                                  Text(prefs.read('my_referral_code') ?? '',
                                      style: defaultTextStyle.copyWith(color: primaryColor, fontSize: 18.sp)),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        FlutterClipboard.copy(prefs.read('my_referral_code')).then((value) =>
                                            sharedController.showSnackbar('Info', 'Kode referral berhasil di salin'));
                                      },
                                      child: Icon(Icons.copy, color: primaryColor)),
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
                        GestureDetector(
                          onTap: () {
                            profilController.lihatData();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lihat Data Saya',
                                  style: defaultTextStyle,
                                ),
                                Icon(Remix.arrow_right_s_line)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.only(
                                                topLeft: const Radius.circular(10.0),
                                                topRight: const Radius.circular(10.0))),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InputFieldWidget(
                                                      tController: tPassword,
                                                      title: 'Password Baru',
                                                      isObscure: true,
                                                    ),
                                                    InputFieldWidget(
                                                      tController: tKonfirmasiPassword,
                                                      title: 'Konfirmasi Password Baru',
                                                      isObscure: true,
                                                    )
                                                  ],
                                                )),
                                            SizedBox(height: 1.0.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(8),
                                                    height: Get.height / 22,
                                                    width: Get.width / 3,
                                                    child: RaisedButton(
                                                      onPressed: () async {
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
                                                            profilController.gantiPassword(tPassword.text);
                                                          }
                                                        }
                                                      },
                                                      color: primaryColor,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8)),
                                                      child: Text(
                                                        'OK',
                                                        style: whiteTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    margin: EdgeInsets.all(8),
                                                    height: Get.height / 22,
                                                    width: Get.width / 3,
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      color: Colors.grey,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8)),
                                                      child: Text(
                                                        'KEMBALI',
                                                        style: whiteTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ganti Password',
                                  style: defaultTextStyle,
                                ),
                                Icon(Remix.arrow_right_s_line)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => PengumumanScreen(true));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tentang Dr. Suheriyatna',
                                style: defaultTextStyle,
                              ),
                              Icon(Remix.arrow_right_s_line)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            prefs.erase();
                            Get.offAll(() => LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Keluar',
                                style: defaultTextStyle.copyWith(color: Colors.red),
                              ),
                              Icon(Remix.arrow_right_s_line)
                            ],
                          ),
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
