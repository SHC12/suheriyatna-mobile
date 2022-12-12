import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../main.dart';

class LoginController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  Future login(var noTelp, BuildContext context) async {
    sharedController.loading(context);
    bool isAvailable = false;
    await relawan.where('no_telp', isEqualTo: noTelp).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        prefs.write('nik', query.docs[0]['nik']);
        prefs.write('noTelp', noTelp);
        prefs.write('namaLengkap', query.docs[0]['nama_lengkap']);
        prefs.write('tempatLahir', query.docs[0]['tempat_lahir']);
        prefs.write('tanggalLahir', query.docs[0]['tanggal_lahir']);
        prefs.write('jenisKelamin', query.docs[0]['jenis_kelamin']);
        prefs.write('golDarah', query.docs[0]['gol_darah']);
        prefs.write('kabupaten', query.docs[0]['kabupaten']);
        prefs.write('kecamatan', query.docs[0]['kecamatan']);
        prefs.write('kelurahan', query.docs[0]['kelurahan']);
        prefs.write('alamat', query.docs[0]['alamat']);
        prefs.write('rtRW', query.docs[0]['rt_rw']);
        prefs.write('pekerjaan', query.docs[0]['pekerjaan']);
        prefs.write('email', query.docs[0]['email']);
        prefs.write('kodeReferral', query.docs[0]['kode_referral']);
        prefs.write('my_referral_code', query.docs[0]['my_referral_code']);
        Get.back();
        Get.offAll(HomeScreen());

        isAvailable = true;
      } else {
        Get.back();
        Get.snackbar(
          'Gagal',
          'No Telepon tidak terdaftar',
          backgroundColor: whiteColor,
        );
        isAvailable = false;
      }
    });

    return isAvailable;
  }
}


// UserCredential result = await auth.signInAnonymously();
    // // await FirebaseAuth.instance.verifyPhoneNumber(
    // //   phoneNumber: '+6281270477940',
    // //   verificationCompleted: (PhoneAuthCredential credential) {},
    // //   verificationFailed: (FirebaseAuthException e) {},
    // //   codeSent: (String verificationId, int? resendToken) {},
    // //   codeAutoRetrievalTimeout: (String verificationId) {},
    // // );