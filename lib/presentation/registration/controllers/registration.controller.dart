import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:suheriyatna_mobile/infrastructure/dal/services/network_service.dart';
import 'package:suheriyatna_mobile/infrastructure/dal/services/url_list_service.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/controllers/kuisioner.controller.dart';
import 'package:suheriyatna_mobile/presentation/registration/registration_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/relawan/controllers/relawan.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../infrastructure/theme/colors.dart';

class RegistrationController extends GetxController {
  NetworkService networkService = Get.put(NetworkService());
  SharedController sharedController = Get.put(SharedController());
  RelawanController relawanController = Get.put(RelawanController());
  KuisionerController kuisionerController = Get.put(KuisionerController());

  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  final CollectionReference dtdc = FirebaseFirestore.instance.collection('DTDC');
  final CollectionReference quickCount = FirebaseFirestore.instance.collection('quick_count');

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
      var jenisKelamin,
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
      XFile image,
      BuildContext context) async {
    sharedController.loading(context);
    var isCheckNik = await checkNIK(nik);
    var isCheckTelepon = await checkTelepon(noTelp);

    if (isCheckNik == false || isCheckTelepon == false) {
      return;
    } else {
      var urlFile = await sharedController.uploadImage(image);
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
        'jenis_kelamin': jenisKelamin,
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
        'is_deleted': false,
        'password': digest.toString(),
        'file_pendukung': urlFile,
        'created_at': DateTime.now()
      });

      if (role == '1') {
        relawanController.addRelawan(nik, namaLengkap, noTelp, jenisKelamin, tempatLahir, tanggalLahir, kabupaten,
            kecamatan, kelurahan, alamat, rt, rw, wilayahKerja, '', XFile('path'), true, context);
      }

      Get.offAll(RegistrationCompleteScreen());
    }
  }

  checkNIK(var nik) async {
    bool isAvailable = false;
    var isRelawanPass = false;
    var isUserPass = false;
    await users.where('nik', isEqualTo: nik).where('is_deleted', isEqualTo: false).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        isUserPass = false;
        // Get.back();
        // Get.snackbar(
        //   'Gagal',
        //   'NIK sudah terdaftar',
        //   backgroundColor: whiteColor,
        // );
        // isAvailable = false;
      } else {
        isUserPass = true;
        // isAvailable = true;
      }
    });
    await relawan.where('nik', isEqualTo: nik).where('is_deleted', isEqualTo: false).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        isRelawanPass = false;
        // Get.back();
        // Get.snackbar(
        //   'Gagal',
        //   'NIK sudah terdaftar',
        //   backgroundColor: whiteColor,
        // );
        // isAvailable = false;
      } else {
        isRelawanPass = true;
        // isAvailable = true;
      }
    });

    if (isRelawanPass == false || isUserPass == false) {
      Get.back();
      Get.snackbar(
        'Gagal',
        'NIK sudah terdaftar',
        backgroundColor: whiteColor,
      );
      isAvailable = false;
    } else {
      isAvailable = true;
    }

    return isAvailable;
  }

  checkTelepon(var noTelp) async {
    bool isAvailable = false;
    var isRelawanPass = false;
    var isUserPass = false;
    await users
        .where('no_telp', isEqualTo: noTelp)
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        isUserPass = false;
        // Get.back();
        // Get.snackbar(
        //   'Gagal',
        //   'Nomor Telepon sudah terdaftar',
        //   backgroundColor: whiteColor,
        // );
        // isAvailable = false;
      } else {
        isUserPass = true;
        // isAvailable = true;
      }
    });
    await relawan
        .where('no_telp', isEqualTo: noTelp)
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        isRelawanPass = false;
        // Get.back();
        // Get.snackbar(
        //   'Gagal',
        //   'Nomor Telepon sudah terdaftar',
        //   backgroundColor: whiteColor,
        // );
        // isAvailable = false;
      } else {
        isRelawanPass = true;
        // isAvailable = true;
      }
    });

    if (isRelawanPass == false || isUserPass == false) {
      Get.back();
      Get.snackbar(
        'Gagal',
        'Nomor Telepon sudah terdaftar',
        backgroundColor: whiteColor,
      );
      isAvailable = false;
    } else {
      isAvailable = true;
    }

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
