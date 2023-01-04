import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../lupa_password_complete.screen.dart';

class LupaPasswordController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference user = FirebaseFirestore.instance.collection('users');
  var isAvailable = false.obs;
  var docID;

  @override
  void onInit() {
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

  checkUser(var nik, var noTelp) async {
    docID = null;
    await user.where('nik', isEqualTo: nik).where('no_telp', isEqualTo: noTelp).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        docID = query.docs.first.id;
        isAvailable.value = true;

        // Get.back();
      } else {
        // Get.back();
        sharedController.showSnackbar('Gagal', 'Data tidak ditemukan');
        isAvailable.value = false;
      }
    });
  }

  changePassword(var password) {
    var hashPassword = sharedController.hash(password);
    user.doc(docID).update({
      'password': hashPassword,
    });
    isAvailable.value = false;
    Get.off(() => LupaPasswordCompleteScreen());
  }
}
