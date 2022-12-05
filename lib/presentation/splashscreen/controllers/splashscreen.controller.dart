import 'dart:async';

import 'package:get/get.dart';

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
      Get.offAll(LoginScreen());
    });
  }
}
