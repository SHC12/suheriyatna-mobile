import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:suheriyatna_mobile/infrastructure/dal/services/network_service.dart';
import 'package:suheriyatna_mobile/infrastructure/dal/services/url_list_service.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/registration/registration_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../infrastructure/theme/colors.dart';

class RegistrationController extends GetxController {
  NetworkService networkService = Get.put(NetworkService());
  SharedController sharedController = Get.put(SharedController());

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  var kabupatenList = [].obs;
  var kecamatanList = [].obs;
  var kelurahanList = [].obs;

  var isSendOTP = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKabupaten();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  registrasiUser(
      var role,
      var nik,
      var namaLengkap,
      var tempatLahir,
      var tanggalLahir,
      var kabupaten,
      var kecamatan,
      var kelurahan,
      var alamat,
      var rt,
      var rw,
      var kodeReferral,
      var noTelp,
      var wilayahKerja,
      var password,
      BuildContext context) async {
    sharedController.loading(context);
    var isCheckNik = await checkNIK(nik);

    if (isCheckNik == false) {
      return;
    } else {
      var referralCode = randomAlpha(6);
      var key = utf8.encode(password);
      var bytes = utf8.encode("foobar");

      var hmacSha256 = Hmac(sha256, key);
      var digest = hmacSha256.convert(bytes);

      await users.add({
        'role': role,
        'my_referral_code': referralCode,
        'nik': nik,
        'nama_lengkap': namaLengkap,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'kabupaten': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'alamat': alamat,
        'rt': rt,
        'rw': rw,
        'kode_referral': kodeReferral,
        'no_telp': noTelp,
        'wilayah_kerja': wilayahKerja,
        'is_verified': false,
        'password': digest.toString(),
        'created_at': DateTime.now()
      });

      Get.offAll(RegistrationCompleteScreen());
    }
  }

  checkNIK(var nik) async {
    bool isAvailable = false;
    await users.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) {
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

  fetchKabupaten() async {
    kabupatenList.clear();
    return networkService.get(
        path: UrlListService.urlKabupaten,
        onSuccess: (content) {
          kabupatenList.assignAll(content);
          print(content);
        },
        onError: (content) {
          print(content);
        });
  }

  fetchKecamatan(var idKabupaten) async {
    kecamatanList.clear();
    return networkService.get(
        path: '${UrlListService.urlKecamatan + idKabupaten}.json',
        onSuccess: (content) {
          kecamatanList.assignAll(content);
          print('kecamatan : $content');
        },
        onError: (content) {
          print('kecamatan : $content');
        });
  }

  fetchKelurahan(var idKecamatan) async {
    kelurahanList.clear();
    return networkService.get(
        path: '${UrlListService.urlKelurahan + idKecamatan}.json',
        onSuccess: (content) {
          kelurahanList.assignAll(content);
          print('kelurahan : $content');
        },
        onError: (content) {
          print('kelurahan : $content');
        });
  }
}
