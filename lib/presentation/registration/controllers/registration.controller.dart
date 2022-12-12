import 'package:cloud_firestore/cloud_firestore.dart';
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

  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');

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

  registrasiRelawan(
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
      var kodeReferral,
      var noTelp,
      BuildContext context) async {
    sharedController.loading(context);
    var isCheckNik = await checkNIK(nik);

    if (isCheckNik == false) {
      return;
    } else {
      var referralCode = randomAlpha(6);
      prefs.write('nik', nik);
      prefs.write('noTelp', noTelp);
      prefs.write('namaLengkap', namaLengkap);
      prefs.write('tempatLahir', tempatLahir);
      prefs.write('tanggalLahir', tanggalLahir);
      prefs.write('jenisKelamin', jenisKelamin);
      prefs.write('golDarah', golDarah);
      prefs.write('kabupaten', kabupaten);
      prefs.write('kecamatan', kecamatan);
      prefs.write('kelurahan', kelurahan);
      prefs.write('alamat', alamat);
      prefs.write('rtRW', rtRW);
      prefs.write('pekerjaan', pekerjaan);
      prefs.write('email', email);
      prefs.write('kodeReferral', kodeReferral);
      prefs.write('my_referral_code', referralCode);

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
        'kode_referral': kodeReferral,
        'no_telp': noTelp,
        'created_at': DateTime.now()
      });

      Get.offAll(RegistrationCompleteScreen());
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
