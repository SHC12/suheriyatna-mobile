import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';

class LupaPasswordCompleteScreen extends StatefulWidget {
  const LupaPasswordCompleteScreen({Key? key}) : super(key: key);

  @override
  State<LupaPasswordCompleteScreen> createState() => _LupaPasswordCompleteScreenState();
}

class _LupaPasswordCompleteScreenState extends State<LupaPasswordCompleteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

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
              'Reset Password Berhasil',
              style: defaultTextStyle.copyWith(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Password Anda berhasil di reset, silahkan login Kembali',
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
                Get.offAll(() => LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
