import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class ApprovalController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference user = FirebaseFirestore.instance.collection('users');

  var userUnverifiedList = [].obs;
  var docIDUserUnverifiedList = [].obs;

  getUnVerified() async {
    await user.where('is_verified', isEqualTo: false).get().then((QuerySnapshot query) async {
      List userUnverifiedListTemp = query.docs.map((e) => e.data()).toList();

      userUnverifiedListTemp.forEach((element) {
        element['id'] = query.docs[userUnverifiedListTemp.indexOf(element)].id;
      });
      userUnverifiedList.assignAll(userUnverifiedListTemp);

      docIDUserUnverifiedList.assignAll(query.docs.map((e) => e.id).toList());

      // print('list user unverified : $userUnverifiedList');
      print('list doc id unverified : $docIDUserUnverifiedList');
    });
  }

  approveUser(var docID) async {
    user.doc(docID).update({'is_verified': true});
    sharedController.showSnackbar('Berhasil', 'User berhasil diverifikasi');
    getUnVerified();
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
}
