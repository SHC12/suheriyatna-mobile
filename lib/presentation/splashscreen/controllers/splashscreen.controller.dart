import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';

import '../../login/login.screen.dart';

class SplashscreenController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    splashscreenStart();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  splashscreenStart() async {
    var duration = const Duration(seconds: 3);

    return Timer(duration, () {
      if (prefs.read('nik') == null) {
        Get.offAll(LoginScreen());
      } else {
        Get.offAll(HomeScreen());
      }
    });
  }
}
