import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';

import '../../infrastructure/theme/colors.dart';
import 'controllers/splashscreen.controller.dart';

class SplashscreenScreen extends StatefulWidget {
  const SplashscreenScreen({Key? key}) : super(key: key);

  @override
  State<SplashscreenScreen> createState() => _SplashscreenScreenState();
}

class _SplashscreenScreenState extends State<SplashscreenScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  SplashscreenController splashscreenController = Get.put(SplashscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/splash_image_new.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Image.asset(
            "assets/images/splash_image_new.png",
            fit: BoxFit.cover,
          ),
        ));
  }
}
