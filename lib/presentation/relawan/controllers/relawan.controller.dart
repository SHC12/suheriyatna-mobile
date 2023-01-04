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

  addRelawan(
      var nik,
      var namaLengkap,
      var noTelp,
      var jenisKelamin,
      var tempatLahir,
      var tanggalLahir,
      var kabupaten,
      var kecamatan,
      var kelurahan,
      var alamat,
      var rt,
      var rw,
      var wilayahKerja,
      XFile image,
      bool isRegistration,
      BuildContext context) async {
    var isCheckNik = await checkNIK(nik);

    if (isCheckNik == false) {
      return;
    } else {
      var referralCode = randomAlpha(6);

      if (isRegistration == true) {
        await relawan.add({
          'my_referral_code': referralCode,
          'nik_referral': '',
          'no_telp_referral': '',
          'nik': nik,
          'nama_lengkap': namaLengkap,
          'no_telp': noTelp,
          'jenis_kelamin': jenisKelamin,
          'tempat_lahir': tempatLahir,
          'tanggal_lahir': tanggalLahir,
          'kabupaten': kabupaten,
          'kecamatan': kecamatan,
          'kelurahan': kelurahan,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'wilayah_kerja': wilayahKerja,
          'file_pendukung': '',
          'kode_referral': '',
          'created_at': DateTime.now()
        });
      } else {
        var urlFile = await sharedController.uploadImage(image);

        await relawan.add({
          'my_referral_code': referralCode,
          'nik_referral': prefs.read('nik'),
          'no_telp_referral': prefs.read('noTelp'),
          'nik': nik,
          'nama_lengkap': namaLengkap,
          'no_telp': noTelp,
          'jenis_kelamin': jenisKelamin,
          'tempat_lahir': tempatLahir,
          'tanggal_lahir': tanggalLahir,
          'kabupaten': kabupaten,
          'kecamatan': kecamatan,
          'kelurahan': kelurahan,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'wilayah_kerja': wilayahKerja,
          'file_pendukung': urlFile,
          'kode_referral': prefs.read('my_referral_code'),
          'created_at': DateTime.now()
        });

        Get.offAll(() => RegistrationRelawanCompleteScreen());
      }
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

  checkNIKValidasi(var nik) async {
    if (nik.length == 16) {
      await relawan.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) {
        if (query.docs.length > 0) {
          Get.snackbar(
            'Gagal',
            'NIK sudah terdaftar',
            backgroundColor: whiteColor,
          );
        } else {
          Get.snackbar(
            'Berhasil',
            'NIK belum terdaftar',
            backgroundColor: whiteColor,
          );
        }
      });
    } else {
      sharedController.showSnackbar('Gagal', 'NIK harus terdiri dari 16 digit');
    }
  }
}
