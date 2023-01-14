import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class PengumumanController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference pengumuman = FirebaseFirestore.instance.collection('pengumuman');

  var isLoading = false.obs;
  var pengumumanList = [].obs;
  File? filePengumuman;

  @override
  void onInit() {
    super.onInit();
    getPengumuman();
  }

  getPengumuman() async {
    await pengumuman
        .where('is_active', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .get()
        .then((QuerySnapshot query) async {
      List dataPengumumanTemo = query.docs.map((e) => e.data()).toList();
      dataPengumumanTemo.forEach((element) {
        element['id'] = query.docs[dataPengumumanTemo.indexOf(element)].id;
      });
      pengumumanList.assignAll(dataPengumumanTemo);

      print('data pengumuman : ${pengumumanList}');
    });
  }

  addPengumuman(var judul, var deskripsi) async {
    sharedController.loading(Get.context!);
    if (filePengumuman == null) {
      pengumuman.add({
        'judul': judul,
        'deskripsi': deskripsi,
        'file_pendukung': null,
        'created_at': DateTime.now(),
        'is_active': true
      }).then((value) {
        Get.back();
        Get.offAll(() => HomeScreen());
        sharedController.showSnackbar('Berhasil', 'Berhasil menambahkan pengumuman');
      }).catchError((e) {
        Get.back();
      });
    } else {
      var urlFile = await sharedController.uploadFile(filePengumuman!);
      pengumuman.add({
        'judul': judul,
        'deskripsi': deskripsi,
        'file_pendukung': urlFile,
        'created_at': DateTime.now(),
        'is_active': true
      }).then((value) {
        Get.back();
        Get.offAll(() => HomeScreen());
        sharedController.showSnackbar('Berhasil', 'Berhasil menambahkan pengumuman');
      }).catchError((e) {
        Get.back();
      });
    }
  }

  editPengumuman(var id, var deskripsi) async {
    sharedController.loading(Get.context!);
    if (filePengumuman == null) {
      pengumuman.doc(id).update({
        'deskripsi': deskripsi,
        'created_at': DateTime.now(),
      }).then((value) {
        Get.back();
        Get.offAll(() => HomeScreen());
        sharedController.showSnackbar('Berhasil', 'Berhasil ubah pengumuman');
      }).catchError((e) {
        Get.back();
      });
    } else {
      var urlFile = await sharedController.uploadFile(filePengumuman!);
      pengumuman.doc(id).update({
        'deskripsi': deskripsi,
        'file_pendukung': urlFile,
        'created_at': DateTime.now(),
      }).then((value) {
        Get.back();
        Get.offAll(() => HomeScreen());
        sharedController.showSnackbar('Berhasil', 'Berhasil ubah pengumuman');
      }).catchError((e) {
        Get.back();
      });
    }
  }

  hapusPengumuman(var id) {
    pengumuman.doc(id).update({'is_active': false}).then((value) {
      Get.back();
      Get.offAll(() => HomeScreen());
      sharedController.showSnackbar('Berhasil', 'Berhasil hapus pengumuman');
    }).catchError((e) {
      Get.back();
    });
  }
}
