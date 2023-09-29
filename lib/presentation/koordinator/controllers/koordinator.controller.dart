import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/registration_koordinator_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class KoordinatorController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference koordinator = FirebaseFirestore.instance.collection('users');
  var dataList = [].obs;

  var totalKoordinatorSelected = 0.obs;

  @override
  void onInit() {
    super.onInit();
    sharedController.fetchKabupaten();
    getKoordinator();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getKoordinator() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: '00')
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) async {
      List dataKoordinatorTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataKoordinatorTemp);
      totalKoordinatorSelected.value = dataList.length;
      print('data relawan : $dataKoordinatorTemp');
    });
  }

  nonAktifkanKoordinator(var nik) async {
    await koordinator.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) async {
      var docIDTemp = query.docs.first.id;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(docIDTemp)
          .update({'is_verified': true, 'is_deleted': true}).then((value) async {
        await getKoordinator();
        Get.back();
        Get.back();
        sharedController.showSnackbar('Berhasil', 'Koordinator berhasil dihapus');
      });
    });
  }

  registrasiKoordinator(
      var nik, var namaLengkap, var noTelp, var wilayahKerja, var password, BuildContext context) async {
    sharedController.loading(context);
    var isCheckNik = await checkNIK(nik);
    var isCheckTelepon = await checkTelepon(noTelp);

    if (isCheckNik == false || isCheckTelepon == false) {
      return;
    } else {
      var key = utf8.encode(password);
      var bytes = utf8.encode("foobar");

      var hmacSha256 = Hmac(sha256, key);
      var digest = hmacSha256.convert(bytes);

      await koordinator.add({
        'role': '00',
        'nik': nik,
        'nama_lengkap': namaLengkap,
        'no_telp': noTelp,
        'wilayah_kerja': wilayahKerja,
        'is_verified': true,
        'is_deleted': false,
        'password': digest.toString(),
        'created_at': DateTime.now()
      });
      Get.back();

      Get.off(RegistrationKoordinatorCompleteScreen());
    }
  }

  getDataKoordinatorByKabupaten(var kabupaten) async {
    await koordinator
        .where('is_deleted', isEqualTo: false)
        .where('is_verified', isEqualTo: true)
        .where('wilayah_kerja', isEqualTo: kabupaten)
        .get()
        .then((QuerySnapshot query) async {
      List dataKoordinatorTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataKoordinatorTemp);

      totalKoordinatorSelected.value = dataList.length;

      print('data relawan : $dataKoordinatorTemp');
    });
  }

  checkNIK(var nik) async {
    bool isAvailable = false;
    await koordinator.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) {
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

  checkTelepon(var noTelp) async {
    bool isAvailable = false;
    await koordinator.where('no_telp', isEqualTo: noTelp).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        Get.back();
        Get.snackbar(
          'Gagal',
          'Nomor Telepon sudah terdaftar',
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

  checkNIKValidasi(var nik, bool isSnackbar) async {
    bool isAvailable = false;
    if (nik.length == 16) {
      await koordinator.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) {
        if (query.docs.length > 0) {
          Get.snackbar(
            'Gagal',
            'NIK sudah terdaftar',
            backgroundColor: whiteColor,
          );
          isAvailable = false;
        } else {
          Get.snackbar(
            'Berhasil',
            'NIK belum terdaftar',
            backgroundColor: whiteColor,
          );
          isAvailable = true;
        }
      });
    } else {
      sharedController.showSnackbar('Gagal', 'NIK harus terdiri dari 16 digit');
    }

    return isAvailable;
  }

  checkTeleponValidasi(var noTelp, bool isSnackbar) async {
    bool isAvailable = false;
    await koordinator.where('no_telp', isEqualTo: noTelp).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        Get.snackbar(
          'Gagal',
          'Nomor Telepon sudah terdaftar',
          backgroundColor: whiteColor,
        );
        isAvailable = false;
      } else {
        Get.snackbar(
          'Berhasil',
          'Nomor Telepon belum terdaftar',
          backgroundColor: whiteColor,
        );
        isAvailable = true;
      }
    });
    return isAvailable;
  }
}
