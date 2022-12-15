import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';

import '../../infrastructure/theme/colors.dart';
import 'controllers/splashscreen.controller.dart';

class SplashscreenScreen extends GetView<SplashscreenController> {
  SplashscreenController splashscreenController = Get.put(SplashscreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 4.h),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              child: Divider(
                                thickness: 1,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 7,
                            child: Text(
                              ' DR. IR. H. SUHERIYATNA M.SI ',
                              style: defaultPrimaryTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              child: Divider(
                                thickness: 1,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Image.asset(
                      'assets/images/splash_image.png',
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'BANGUN\nKALTARA\n2024',
                      textAlign: TextAlign.center,
                      style: defaultTextStyle.copyWith(fontSize: 44.sp, color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ));
  }
}
