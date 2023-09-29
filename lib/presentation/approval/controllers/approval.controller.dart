import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../../main.dart';

class ApprovalController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference user = FirebaseFirestore.instance.collection('users');
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');

  var userUnverifiedList = [].obs;
  var docIDUserUnverifiedList = [].obs;
  var dataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    if (prefs.read('role') == '0' || prefs.read('role') == '00') {
      getUnVerified();
      // getDataTimsesDummy();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUnVerified() async {
    if (prefs.read('role') == '00') {
      await user
          .where(
            'is_verified',
            isEqualTo: false,
          )
          .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
          .get()
          .then((QuerySnapshot query) async {
        List userUnverifiedListTemp = query.docs.map((e) => e.data()).toList();
        userUnverifiedListTemp.forEach((element) {
          element['id'] = query.docs[userUnverifiedListTemp.indexOf(element)].id;
        });
        userUnverifiedList.assignAll(userUnverifiedListTemp);
        docIDUserUnverifiedList.assignAll(query.docs.map((e) => e.id).toList());
      });
    } else {
      await user.where('is_verified', isEqualTo: false).get().then((QuerySnapshot query) async {
        List userUnverifiedListTemp = query.docs.map((e) => e.data()).toList();
        userUnverifiedListTemp.forEach((element) {
          element['id'] = query.docs[userUnverifiedListTemp.indexOf(element)].id;
        });
        userUnverifiedList.assignAll(userUnverifiedListTemp);
        docIDUserUnverifiedList.assignAll(query.docs.map((e) => e.id).toList());
      });
    }
  }

  approveUser(var docID) async {
    user.doc(docID).update({'is_verified': true});
    sharedController.showSnackbar('Berhasil', 'User berhasil diverifikasi');
    getUnVerified();
  }

  approveRelawan(var docID, var kabupaten) async {
    if (kabupaten == null) {
      await relawan.doc(docID).update({'is_verified': true});
      await getDataRelawan();
      sharedController.showSnackbar('Berhasil', 'Relawan berhasil di approve');
    } else {
      await relawan.doc(docID).update({'is_verified': true});
      await getDataRelawanByKabupaten(kabupaten);
      sharedController.showSnackbar('Berhasil', 'Relawan berhasil di approve');
    }
  }

  approveAllUser(BuildContext context) async {
    sharedController.loading(context);
    await Future.forEach(docIDUserUnverifiedList, (element) {
      user.doc(element.toString()).update({'is_verified': true});
    }).then((value) {
      Get.back();
      sharedController.showSnackbar('Berhasil', 'Semua user berhasil diverifikasi');
      getUnVerified();
    });
  }

  approveAllRelawan(BuildContext context, var kabupaten) async {
    sharedController.loading(context);
    var docIDList = dataList.map((e) => e['id']).toList();

    await Future.forEach(docIDList, (element) {
      relawan.doc(element.toString()).update({'is_verified': true});
    }).then((value) async {
      print('kabupaten : $kabupaten');
      if (kabupaten == null) {
        await getDataRelawan();
        Get.back();
        sharedController.showSnackbar('Berhasil', 'Semua relawan berhasil diverifikasi');
      } else {
        await getDataRelawanByKabupaten(kabupaten);
        Get.back();
        sharedController.showSnackbar('Berhasil', 'Semua relawan berhasil diverifikasi');
      }
    });
  }

  getDataRelawan() async {
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('relawan')
          .where('is_verified', isEqualTo: false)
          .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
          .get()
          .then((QuerySnapshot query) async {
        List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        dataRelawanTemp.forEach((element) {
          element['id'] = query.docs[dataRelawanTemp.indexOf(element)].id;
        });
        dataList.assignAll(dataRelawanTemp);
      });
    } else {
      await FirebaseFirestore.instance
          .collection('relawan')
          .where('is_verified', isEqualTo: false)
          .get()
          .then((QuerySnapshot query) async {
        List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        dataRelawanTemp.forEach((element) {
          element['id'] = query.docs[dataRelawanTemp.indexOf(element)].id;
        });
        dataList.assignAll(dataRelawanTemp);
      });
    }
  }

  deleteAllRelawanDummy(BuildContext context, var kabupaten) async {
    sharedController.loading(context);
    var docIDList = dataList.map((e) => e['id']).toList();

    await Future.forEach(docIDList, (element) {
      relawan.doc(element.toString()).delete();
    }).then((value) async {
      print('done');
      Get.back();
    });
  }

  getDataRelawanDummy() async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('my_referral_code', isEqualTo: '')
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataRelawanTemp.forEach((element) {
        element['id'] = query.docs[dataRelawanTemp.indexOf(element)].id;
      });
      dataList.assignAll(dataRelawanTemp);

      print('length relawan : ${dataList.length}');
    });
  }

  deleteAllTimsesDummy() async {
    sharedController.loading(Get.context!);
    var docIDList = docIDUserUnverifiedList.map((e) => e['id']).toList();

    await Future.forEach(docIDList, (element) {
      user.doc(element.toString()).delete();
    }).then((value) async {
      print('done');
      Get.back();
    });
  }

  getDataTimsesDummy() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('isDummy', isEqualTo: true)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataRelawanTemp.forEach((element) {
        element['id'] = query.docs[dataRelawanTemp.indexOf(element)].id;
      });
      docIDUserUnverifiedList.assignAll(dataRelawanTemp);

      print('length timses dummy : ${docIDUserUnverifiedList.length}');
    });
  }

  getDataRelawanByKabupaten(var kabupaten) async {
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('relawan')
          .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
          .where('is_verified', isEqualTo: false)
          .get()
          .then((QuerySnapshot query) async {
        List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        dataRelawanTemp.forEach((element) {
          element['id'] = query.docs[dataRelawanTemp.indexOf(element)].id;
        });
        dataList.assignAll(dataRelawanTemp);
      });
    } else {
      await FirebaseFirestore.instance
          .collection('relawan')
          .where('kabupaten', isEqualTo: kabupaten)
          .where('is_verified', isEqualTo: false)
          .get()
          .then((QuerySnapshot query) async {
        List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        dataRelawanTemp.forEach((element) {
          element['id'] = query.docs[dataRelawanTemp.indexOf(element)].id;
        });
        dataList.assignAll(dataRelawanTemp);
      });
    }
  }
}
