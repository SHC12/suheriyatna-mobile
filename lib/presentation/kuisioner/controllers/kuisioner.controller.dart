import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/kuisioner/kuisioner_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class KuisionerController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference dtdc = FirebaseFirestore.instance.collection('DTDC');
  var dataKuisioner = [].obs;
  @override
  void onInit() {
    getKuisionerList();
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

  addKuisioner(var namaLengkap, var jenisKelamin, var kabupaten, var kecamatan, var kelurahan, var isMengenal,
      XFile image, BuildContext context) async {
    sharedController.loading(context);
    var urlFile = await sharedController.uploadImage(image);

    await dtdc.add({
      'nik_relawan': prefs.read('nik'),
      'no_telp_relawan': prefs.read('noTelp'),
      'nama_kuisioner': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'kabupaten': kabupaten,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'is_mengenal': isMengenal,
      'file_pendukung': urlFile,
      'created_at': DateTime.now()
    });

    Get.offAll(KuisionerCompleteScreen());
  }

  getKuisionerList() async {
    await dtdc.where('nik_relawan', isEqualTo: prefs.read('nik')).get().then((QuerySnapshot query) async {
      List dataKuisionerTemp = query.docs.map((e) => e.data()).toList();
      dataKuisioner.assignAll(dataKuisionerTemp);

      print('data kuisioner : $dataKuisionerTemp');
    });
  }
}
