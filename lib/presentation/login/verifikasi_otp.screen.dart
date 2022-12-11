import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';

class VerifikasiOTPSCreen extends StatefulWidget {
  const VerifikasiOTPSCreen({Key? key}) : super(key: key);

  @override
  State<VerifikasiOTPSCreen> createState() => _VerifikasiOTPSCreenState();
}

class _VerifikasiOTPSCreenState extends State<VerifikasiOTPSCreen> {
  final CountdownController _controller = new CountdownController(autoStart: true);

  bool? isTimerResend = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Lottie.asset('assets/lottie/otp.json', width: 60.w),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Verifikasi',
                  style: defaultPrimaryTextStyle.copyWith(
                    fontSize: 20.0.sp,
                  ),
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                  child: Pinput(
                    length: 6,
                    validator: (s) {
                      // return s == '2222' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                  ),
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.0.w, right: 4.0.w),
                  child: Text(
                    'Silahkan masukkan kode verifikasi yang sudah terkirim ke no hp Anda',
                    style:
                        defaultTextStyle.copyWith(fontSize: 12.0.sp, color: greyTextColor, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Countdown(
                  controller: _controller,
                  seconds: 60,
                  build: (_, double time) => Visibility(
                    visible: isTimerResend!,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mohon tunggu dalam ',
                          style: defaultTextStyle.copyWith(fontSize: 12.0.sp, color: greyTextColor),
                        ),
                        Text(time.toString().substring(0, time.toString().indexOf('.')) + ' detik',
                            style: defaultPrimaryTextStyle.copyWith(
                              fontSize: 12.0.sp,
                            )),
                        Text(
                          ' untuk kirim ulang',
                          style: defaultTextStyle.copyWith(fontSize: 12.0.sp, color: greyTextColor),
                        ),
                      ],
                    ),
                  ),
                  interval: Duration(milliseconds: 100),
                  onFinished: () {
                    setState(() {
                      isTimerResend = false;
                    });
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                Visibility(
                  visible: isTimerResend == true ? false : true,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum menerima kode?',
                        style: defaultTextStyle.copyWith(fontSize: 12.0.sp, color: greyTextColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 2.0.w),
                      InkWell(
                        onTap: () async {
                          _controller.restart();
                          setState(() {
                            isTimerResend = true;
                          });
                        },
                        child: Text(
                          'Kirim Ulang',
                          style: defaultPrimaryTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      resizeToAvoidBottomInset: false,
    );
  }
}
