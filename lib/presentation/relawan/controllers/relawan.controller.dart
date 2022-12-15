import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/registration/controllers/registration.controller.dart';
import 'package:suheriyatna_mobile/presentation/relawan/registration_relawan_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../infrastructure/theme/colors.dart';

class RelawanController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  RegistrationController registrationController = Get.put(RegistrationController());
  var docID = ''.obs;
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');

  var dataRelawan = [].obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    await getDocID();
    await getRelawanList();
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

  getDocID() async {
    await relawan.where('nik', isEqualTo: prefs.read('nik')).get().then((QuerySnapshot query) {
      docID.value = query.docs.first.id;

      print('doc id : ${docID.value}');
    });
  }

  getRelawanList() async {
    isLoading(true);
    await FirebaseFirestore.instance
        .collection('relawan')
        .doc(docID.value)
        .collection('sub_relawan')
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataRelawan.assignAll(dataRelawanTemp);
      isLoading(false);
      print('data sub relawan : $dataRelawanTemp');
    });
  }

  registrasiSubRelawan(
      var nik,
      var namaLengkap,
      var tempatLahir,
      var tanggalLahir,
      var jenisKelamin,
      var golDarah,
      var kabupaten,
      var kecamatan,
      var kelurahan,
      var alamat,
      var rtRW,
      var pekerjaan,
      var email,
      var noTelp,
      XFile image,
      BuildContext context) async {
    sharedController.loading(context);
    var isCheckNik = await checkNIK(nik);

    if (isCheckNik == false) {
      return;
    } else {
      final CollectionReference subRelawan =
          FirebaseFirestore.instance.collection('relawan').doc(docID.value).collection('sub_relawan');
      var referralCode = randomAlpha(6);

      var urlFile = await sharedController.uploadImage(image);

      await subRelawan.add({
        'my_referral_code': referralCode,
        'nik': nik,
        'nama_lengkap': namaLengkap,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'jenis_kelamin': jenisKelamin,
        'gol_darah': golDarah,
        'kabupaten': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'alamat': alamat,
        'rt_rw': rtRW,
        'pekerjaan': pekerjaan,
        'email': email,
        'kode_referral': prefs.read('my_referral_code'),
        'no_telp': noTelp,
        'file_pendukung': urlFile,
        'created_at': DateTime.now()
      });

      await relawan.add({
        'my_referral_code': referralCode,
        'nik': nik,
        'nama_lengkap': namaLengkap,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'jenis_kelamin': jenisKelamin,
        'gol_darah': golDarah,
        'kabupaten': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'alamat': alamat,
        'rt_rw': rtRW,
        'pekerjaan': pekerjaan,
        'email': email,
        'kode_referral': prefs.read('my_referral_code'),
        'no_telp': noTelp,
        'created_at': DateTime.now()
      });

      Get.offAll(() => RegistrationRelawanCompleteScreen());
    }
  }

  checkNIK(var nik) async {
    bool isAvailable = false;
    await relawan.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        Get.back();
        Get.snackbar(
          'Gagal',
          'NIK sudah terdaftar',
          backgroundColor: whiteColor,
        );
        isAvailable = false;
      } else {
        print('NIK belum terdaftar');
        isAvailable = true;
      }
    });

    return isAvailable;
  }
}
