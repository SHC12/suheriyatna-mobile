import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path/path.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/confirm_dialog.widget.dart';

import '../../../infrastructure/dal/services/network_service.dart';
import '../../../infrastructure/dal/services/url_list_service.dart';
import '../../../infrastructure/theme/colors.dart';
import '../widget/loading.widget.dart';

class SharedController extends GetxController {
  NetworkService networkService = Get.put(NetworkService());

  UploadTask? uploadTask;

  var kabupatenList = [].obs;
  var kecamatanList = [].obs;
  var kelurahanList = [].obs;

  // sendOTP() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+6283186552074',
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

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

  uploadFile(File file) async {
    var fileName = basename(file.path);
    final path = 'files/${fileName}';

    final fileTemp = file;
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(fileTemp);

    final snapshot = await uploadTask!.whenComplete(() => {});
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }

  hash(var text) {
    var key = utf8.encode(text);
    var bytes = utf8.encode("foobar");

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }

  fetchKabupaten() async {
    kabupatenList.clear();
    return networkService.get(
        path: UrlListService.urlKabupaten,
        onSuccess: (content) {
          kabupatenList.assignAll(content);

          if (prefs.read('role') == '00') {
            var kabupatenIDbyName =
                kabupatenList.where((element) => element['name'] == prefs.read('wilayahKerja')).toList();
            print('value b : $kabupatenIDbyName');
            kabupatenList.assignAll(kabupatenIDbyName);
          }
        },
        onError: (content) {
          // print(content);
        });
  }

  fetchKecamatan(var idKabupaten) async {
    kecamatanList.clear();
    return networkService.get(
        path: '${UrlListService.urlKecamatan + idKabupaten}.json',
        onSuccess: (content) {
          kecamatanList.assignAll(content);
          // print('kecamatan : $content');
        },
        onError: (content) {
          // print('kecamatan : $content');
        });
  }

  fetchKelurahan(var idKecamatan) async {
    kelurahanList.clear();
    return networkService.get(
        path: '${UrlListService.urlKelurahan + idKecamatan}.json',
        onSuccess: (content) {
          kelurahanList.assignAll(content);
        },
        onError: (content) {});
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

  exportExcel(List data, var nameFile) async {
    loading(Get.context!);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var excel = Excel.createExcel();

    var sheet = excel['sheet'];

    sheet.appendRow([
      'No',
      'NIK',
      'Nama Lengkap',
      'No Telp',
      'Jenis Kelamin',
      'Tempat Lahir',
      'Tanggal Lahir',
      'Kabupaten',
      'Kecamatan',
      'Kelurahan',
      'Alamat',
      'RT/RW',
      'Tanggal Pendaftaran',
      'Wilayah Kerja',
      'TPS',
      'Kode Referral',
      'Kode Referral Pendaftar'
    ]);
    int index = 0;
    data.forEach((row) {
      Timestamp t = row['created_at'];
      index++;
      sheet.appendRow([
        index,
        row['nik'],
        row['nama_lengkap'],
        row['no_telp'],
        row['jenis_kelamin'],
        row['tempat_lahir'],
        row['tanggal_lahir'],
        row['kabupaten'],
        row['kecamatan'],
        row['kelurahan'],
        row['alamat'],
        row['rt'] + '/' + row['rw'],
        DateFormat('dd-MM-yyyy').format(DateTime.parse(t.toDate().toString())),
        row['wilayah_kerja'],
        row['tps'] == null ? '' : row['tps'],
        row['my_referral_code'],
        row['kode_referral'],
      ]);
    });

    bool isSet = excel.setDefaultSheet(sheet.sheetName);

    if (isSet) {
      print("${sheet.sheetName} is set to default sheet.");
    } else {
      print("Unable to set ${sheet.sheetName} to default sheet.");
    }

    String? downloadsDirectoryPath = (await DownloadsPath.downloadsDirectory())?.path;

    var fileBytes = excel.save();

    File(join("${downloadsDirectoryPath}/$nameFile.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    Get.back();
    showSnackbar('Berhasil Export Data', 'Download/$nameFile.xlsx');

    print("${downloadsDirectoryPath}/$nameFile.xlsx");
  }

  exportExcelTimses(List data, var nameFile) async {
    loading(Get.context!);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var excel = Excel.createExcel();

    var sheet = excel['sheet'];

    sheet.appendRow([
      'No',
      'NIK',
      'Nama Lengkap',
      'No Telp',
      'Jenis Kelamin',
      'Tempat Lahir',
      'Tanggal Lahir',
      'Kabupaten',
      'Kecamatan',
      'Kelurahan',
      'Alamat',
      'RT/RW',
      'Tanggal Pendaftaran',
      'Wilayah Kerja',
      'Total Relawan',
      'Kode Referral',
      'Kode Referral Pendaftar'
    ]);
    int index = 0;
    data.forEach((row) {
      Timestamp t = row['created_at'];
      index++;
      sheet.appendRow([
        index,
        row['nik'],
        row['nama_lengkap'],
        row['no_telp'],
        row['jenis_kelamin'],
        row['tempat_lahir'],
        row['tanggal_lahir'],
        row['kabupaten'],
        row['kecamatan'],
        row['kelurahan'],
        row['alamat'],
        row['rt'] + '/' + row['rw'],
        DateFormat('dd-MM-yyyy').format(DateTime.parse(t.toDate().toString())),
        row['wilayah_kerja'],
        row['total_relawan'],
        row['my_referral_code'],
        row['kode_referral'],
      ]);
    });

    bool isSet = excel.setDefaultSheet(sheet.sheetName);

    if (isSet) {
      print("${sheet.sheetName} is set to default sheet.");
    } else {
      print("Unable to set ${sheet.sheetName} to default sheet.");
    }

    String? downloadsDirectoryPath = (await DownloadsPath.downloadsDirectory())?.path;

    var fileBytes = excel.save();

    File(join("${downloadsDirectoryPath}/$nameFile.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    Get.back();
    showSnackbar('Berhasil Export Data', 'Download/$nameFile.xlsx');

    print("${downloadsDirectoryPath}/$nameFile.xlsx");
  }

  exportExcelKuisioner(List data, var nameFile) async {
    loading(Get.context!);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var excel = Excel.createExcel();

    var sheet = excel['sheet'];

    sheet.appendRow([
      'No',
      'NIK Relawan',
      'No Telp Relawan',
      'Nama Kuisioner',
      'Jenis Kelamin Kuisioner',
      'Kabupaten',
      'Kecamatan',
      'Kelurahan',
      'Tanggal Kuisioner',
      'Apakah Mengenal Suheriyatna ?'
    ]);
    int index = 0;
    data.forEach((row) {
      Timestamp t = row['created_at'];
      index++;
      sheet.appendRow([
        index,
        row['nik_relawan'],
        row['no_telp_relawan'],
        row['nama_kuisioner'],
        row['jenis_kelamin'],
        row['kabupaten'],
        row['kecamatan'],
        row['kelurahan'],
        DateFormat('dd-MM-yyyy').format(DateTime.parse(t.toDate().toString())),
        row['is_mengenal']
      ]);
    });

    bool isSet = excel.setDefaultSheet(sheet.sheetName);

    if (isSet) {
      print("${sheet.sheetName} is set to default sheet.");
    } else {
      print("Unable to set ${sheet.sheetName} to default sheet.");
    }

    String? downloadsDirectoryPath = (await DownloadsPath.downloadsDirectory())?.path;

    var fileBytes = excel.save();

    File(join("${downloadsDirectoryPath}/$nameFile.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    Get.back();
    showSnackbar('Berhasil Export Data', 'Download/$nameFile.xlsx');
    print("${downloadsDirectoryPath}/$nameFile.xlsx");
  }
}
