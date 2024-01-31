import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/cek_data/controllers/cek_data.controller.dart';
import 'package:suheriyatna_mobile/presentation/registration/controllers/registration.controller.dart';
import 'package:suheriyatna_mobile/presentation/relawan/registration_relawan_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../infrastructure/theme/colors.dart';

class RelawanController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  CekDataController cekDataController = Get.put(CekDataController());
  var docID = ''.obs;
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  final CollectionReference user = FirebaseFirestore.instance.collection('users');

  var totalTimsesSelected = 0.obs;

  var dataRelawan = [].obs;

  var isLoading = false.obs;

  var nameReferral = ''.obs;

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
    if (prefs.read('role') != '00' || prefs.read('role') != '0') {
      docID.value = prefs.read('nik');
      return;
    }
    await relawan.where('nik', isEqualTo: prefs.read('nik')).get().then((QuerySnapshot query) {
      docID.value = query.docs.first.id;

      print('doc id : ${docID.value}');
    });
  }

  getRelawanList() async {
    isLoading(true);
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('relawan')
          .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
          .where('is_deleted', isEqualTo: false)
          .get()
          .then((QuerySnapshot query) async {
        // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        // dataRelawan.assignAll(dataRelawanTemp);
        // totalTimsesSelected.value = dataRelawan.length;
        // isLoading(false);

        List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

        var a = [];
        dataRelawanTemp.forEach((element) {
          if (a
              .where((elementa) =>
                  element['nik'] == elementa['nik'] &&
                  element['nama_lengkap'] == elementa['nama_lengkap'] &&
                  element['no_telp'] == elementa['no_telp'])
              .toList()
              .isEmpty) {
            a.add(element);
          }
        });

        dataRelawan.assignAll(a);
        totalTimsesSelected.value = dataRelawan.length;
        isLoading(false);
      });
    } else {
      await FirebaseFirestore.instance
          .collection('relawan')
          .doc(docID.value)
          .collection('sub_relawan')
          .get()
          .then((QuerySnapshot query) async {
        // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        // dataRelawan.assignAll(dataRelawanTemp);
        // totalTimsesSelected.value = dataRelawan.length;
        // isLoading(false);
        // print('data sub relawan : $dataRelawanTemp');
        List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

        var a = [];
        dataRelawanTemp.forEach((element) {
          if (a
              .where((elementa) =>
                  element['nik'] == elementa['nik'] &&
                  element['nama_lengkap'] == elementa['nama_lengkap'] &&
                  element['no_telp'] == elementa['no_telp'])
              .toList()
              .isEmpty) {
            a.add(element);
          }
        });

        dataRelawan.assignAll(a);
        totalTimsesSelected.value = dataRelawan.length;
        isLoading(false);
      });
    }
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
      var tps,
      XFile image,
      bool isRegistration,
      BuildContext context) async {
    var isCheckNik = await checkNIK(nik);
    var isCheckTelepon = await checkTelepon(noTelp);

    if (isCheckNik == false || isCheckTelepon == false) {
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
          'tps': tps,
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
          'tps': tps,
          'file_pendukung': urlFile,
          'is_verified': false,
          'is_deleted': false,
          'kode_referral': prefs.read('my_referral_code'),
          'created_at': DateTime.now()
        });

        Get.offAll(() => RegistrationRelawanCompleteScreen());
      }
    }
  }

  checkNIK(var nik) async {
    bool isAvailable = false;
    var isRelawanPass = false;
    var isUserPass = false;
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
        // print('NIK belum terdaftar');
        // isAvailable = true;
      }
    });
    await user.where('nik', isEqualTo: nik).where('is_deleted', isEqualTo: false).get().then((QuerySnapshot query) {
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
        // print('NIK belum terdaftar');
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
    await user
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

  checkNIKValidasi(var nik) async {
    var isRelawanPass = false;
    var isUserPass = false;
    if (nik.length == 16) {
      await relawan
          .where('nik', isEqualTo: nik)
          .where('is_deleted', isEqualTo: false)
          .get()
          .then((QuerySnapshot query) {
        if (query.docs.length > 0) {
          isRelawanPass = false;
          // Get.snackbar(
          //   'Gagal',
          //   'NIK sudah terdaftar',
          //   backgroundColor: whiteColor,
          // );
        } else {
          isRelawanPass = true;
          // Get.snackbar(
          //   'Berhasil',
          //   'NIK belum terdaftar',
          //   backgroundColor: whiteColor,
          // );
        }
      });
      await user.where('nik', isEqualTo: nik).where('is_deleted', isEqualTo: false).get().then((QuerySnapshot query) {
        if (query.docs.length > 0) {
          isUserPass = false;
          // Get.snackbar(
          //   'Gagal',
          //   'NIK sudah terdaftar',
          //   backgroundColor: whiteColor,
          // );
        } else {
          isUserPass = true;
          // Get.snackbar(
          //   'Berhasil',
          //   'NIK belum terdaftar',
          //   backgroundColor: whiteColor,
          // );
        }
      });

      if (isUserPass == false || isRelawanPass == false) {
        Get.snackbar(
          'Gagal',
          'NIK sudah terdaftar',
          backgroundColor: whiteColor,
        );
        return false;
      } else {
        Get.snackbar(
          'Berhasil',
          'NIK belum terdaftar',
          backgroundColor: whiteColor,
        );
        return true;
      }
    } else {
      sharedController.showSnackbar('Gagal', 'NIK harus terdiri dari 16 digit');
    }
  }

  checkTeleponValidasi(var noTelp) async {
    var isRelawanPass = false;
    var isUserPass = false;
    await relawan
        .where('no_telp', isEqualTo: noTelp)
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        isRelawanPass = false;
        // Get.snackbar(
        //   'Gagal',
        //   'Nomor Telepon sudah terdaftar',
        //   backgroundColor: whiteColor,
        // );
      } else {
        isRelawanPass = true;
        // Get.snackbar(
        //   'Berhasil',
        //   'Nomor Telepon belum terdaftar',
        //   backgroundColor: whiteColor,
        // );
      }
    });
    await user
        .where('no_telp', isEqualTo: noTelp)
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        isUserPass = false;
        // Get.snackbar(
        //   'Gagal',
        //   'Nomor Telepon sudah terdaftar',
        //   backgroundColor: whiteColor,
        // );
      } else {
        isUserPass = true;
        // Get.snackbar(
        //   'Berhasil',
        //   'Nomor Telepon belum terdaftar',
        //   backgroundColor: whiteColor,
        // );
      }
    });
    if (isRelawanPass == false || isUserPass == false) {
      Get.snackbar(
        'Gagal',
        'Nomor Telepon sudah terdaftar',
        backgroundColor: whiteColor,
      );
      return false;
    } else {
      Get.snackbar(
        'Berhasil',
        'Nomor Telepon belum terdaftar',
        backgroundColor: whiteColor,
      );
      return true;
    }
  }

  nonAktifRelawan(var nik) async {
    print('nik : $nik');
    await FirebaseFirestore.instance
        .collection('users')
        .where('nik', isEqualTo: nik)
        .get()
        .then((QuerySnapshot query) async {
      if (query.docs.length > 0) {
        var docIDTemp = query.docs.first.id;
        await FirebaseFirestore.instance.collection('users').doc(docIDTemp).update({'is_verified': false});
        await hapusRelawan(nik);
      } else {
        await hapusRelawan(nik);
      }
    });
  }

  hapusRelawan(var nik) async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('nik', isEqualTo: nik)
        .get()
        .then((QuerySnapshot query) async {
      var docIDTemp = query.docs.first.id;
      FirebaseFirestore.instance.collection('relawan').doc(docIDTemp).update({'is_deleted': true}).then((value) async {
        await cekDataController.getDataRelawan();
        Get.back();
        Get.back();
        sharedController.showSnackbar('Berhasil', 'Relawan berhasil dihapus');
      });
    });
  }

  getReferral(var nikRefferal) async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('nik', isEqualTo: nikRefferal)
        .get()
        .then((QuerySnapshot query) async {
      if (query.docs.length > 0) {
        var docIDTemp = query.docs.first.id;
        var dataRelawanTemp = query.docs.first.data();

        nameReferral.value = query.docs[0]['nama_lengkap'];
      } else {}
    });
  }
}
