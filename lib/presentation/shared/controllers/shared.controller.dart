import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/colors.dart';
import '../widget/loading.widget.dart';

class SharedController extends GetxController {
  //TODO: Implement SharedController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+6283186552074',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: whiteColor,
    );
  }

  loading(BuildContext context) async {
    showDialog(barrierDismissible: true, context: context, builder: (BuildContext context) => LoadingDialogWidget());
  }

  String getInitials(String nama) => nama.isNotEmpty ? nama.trim().split(' ').map((l) => l[0]).take(2).join() : '';
}
