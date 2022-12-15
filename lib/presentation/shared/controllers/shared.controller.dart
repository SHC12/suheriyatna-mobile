import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/confirm_dialog.widget.dart';

import '../../../infrastructure/theme/colors.dart';
import '../widget/loading.widget.dart';

class SharedController extends GetxController {
  UploadTask? uploadTask;

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

  uploadImage(XFile image) async {
    final path = 'files/${image.name}';

    final file = File(image.path);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }

  popUpMessage(var titleMessage, var message, var titleButtonNo, var tittleButtonYes, Function() onTap, bool isButton,
      BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => ConfirmDialogWidget(
              titleMessage: titleMessage,
              message: message,
              titleButtonNo: titleButtonNo,
              titleButtonYes: tittleButtonYes,
              onTapYes: onTap,
              isButton: isButton,
            ));
  }

  String getInitials(String nama) => nama.isNotEmpty ? nama.trim().split(' ').map((l) => l[0]).take(2).join() : '';
}
