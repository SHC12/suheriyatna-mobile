import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../infrastructure/theme/colors.dart';
import 'controllers/splashscreen.controller.dart';

class SplashscreenScreen extends GetView<SplashscreenController> {
  SplashscreenController splashscreenController = Get.put(SplashscreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          child: Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100.sp,

                  backgroundImage: AssetImage('assets/images/main_logo.png'),
                  // child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(50), child: Image.asset('assets/images/main_logo.png')),
                ),
              )
            ],
          ),
        ));
  }
}
