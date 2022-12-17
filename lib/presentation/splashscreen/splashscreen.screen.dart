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
            top: true,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/gif/splashscreen.gif"),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.w),
            )));
  }
}
