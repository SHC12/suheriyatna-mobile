import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';

class RegistrationRelawanCompleteScreen extends StatefulWidget {
  const RegistrationRelawanCompleteScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationRelawanCompleteScreen> createState() => _RegistrationRelawanCompleteScreenState();
}

class _RegistrationRelawanCompleteScreenState extends State<RegistrationRelawanCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('assets/lottie/registrasi_done.json', width: 80.w),
            ),
            Text(
              'Registrasi Relawan Berhasil',
              style: defaultTextStyle.copyWith(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.h,
            ),
            ButtonWidget(
              color: secondaryColor,
              title: 'Kembali',
              onTap: () {
                Get.offAll(() => HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
