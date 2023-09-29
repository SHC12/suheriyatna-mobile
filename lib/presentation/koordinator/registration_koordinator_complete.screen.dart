import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';

class RegistrationKoordinatorCompleteScreen extends StatefulWidget {
  const RegistrationKoordinatorCompleteScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationKoordinatorCompleteScreen> createState() => _RegistrationKoordinatorCompleteScreenState();
}

class _RegistrationKoordinatorCompleteScreenState extends State<RegistrationKoordinatorCompleteScreen> {
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
              'Registrasi Koordinator Berhasil',
              style: defaultTextStyle.copyWith(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Koordinator Timses Berhasil Ditambah',
              textAlign: TextAlign.center,
              style: defaultTextStyle.copyWith(fontSize: 12.0.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            ButtonWidget(
              color: secondaryColor,
              title: 'Kembali',
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
