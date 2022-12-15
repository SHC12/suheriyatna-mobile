import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';

class KuisionerCompleteScreen extends StatefulWidget {
  const KuisionerCompleteScreen({Key? key}) : super(key: key);

  @override
  State<KuisionerCompleteScreen> createState() => _KuisionerCompleteScreenState();
}

class _KuisionerCompleteScreenState extends State<KuisionerCompleteScreen> {
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
              'Kuisioner Berhasil Disimpan',
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
