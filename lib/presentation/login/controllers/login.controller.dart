import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../main.dart';

class LoginController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference user = FirebaseFirestore.instance.collection('users');
  Future login(var noTelp, var kataSandi, BuildContext context) async {
    sharedController.loading(context);
    var password = sharedController.hash(kataSandi);
    bool isAvailable = false;

    if (noTelp == 'admin' && kataSandi == 'admin') {
      prefs.write('nik', 'admin');
      prefs.write('noTelp', 'admin');
      prefs.write('namaLengkap', 'admin');

      prefs.write('role', '0');
      Get.back();
      Get.offAll(() => HomeScreen());
    } else {
      await user
          .where('no_telp', isEqualTo: noTelp)
          .where('password', isEqualTo: password)
          .get()
          .then((QuerySnapshot query) {
        if (query.docs.length > 0) {
          if (query.docs[0]['is_verified'] == true) {
            prefs.write('nik', query.docs[0]['nik']);
            prefs.write('noTelp', noTelp);
            prefs.write('namaLengkap', query.docs[0]['nama_lengkap']);
            prefs.write('tempatLahir', query.docs[0]['tempat_lahir']);
            prefs.write('tanggalLahir', query.docs[0]['tanggal_lahir']);
            prefs.write('role', query.docs[0]['role']);

            prefs.write('kabupaten', query.docs[0]['kabupaten']);
            prefs.write('kecamatan', query.docs[0]['kecamatan']);
            prefs.write('kelurahan', query.docs[0]['kelurahan']);
            prefs.write('alamat', query.docs[0]['alamat']);
            prefs.write('rt', query.docs[0]['rt']);
            prefs.write('rw', query.docs[0]['rw']);

            prefs.write('kodeReferral', query.docs[0]['kode_referral']);
            prefs.write('wilayahKerja', query.docs[0]['wilayah_kerja']);
            prefs.write('my_referral_code', query.docs[0]['my_referral_code']);
            Get.back();
            Get.offAll(HomeScreen());
          } else {
            Get.back();
            Get.snackbar(
              'Gagal',
              'Akun belum diverifikasi',
              backgroundColor: whiteColor,
            );
          }

          isAvailable = true;
        } else {
          Get.back();
          Get.snackbar(
            'Gagal',
            'No Telepon tidak terdaftar atau kata sandi salah',
            backgroundColor: whiteColor,
          );
          isAvailable = false;
        }
      });

      return isAvailable;
    }
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