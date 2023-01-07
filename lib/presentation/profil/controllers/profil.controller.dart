import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class ProfilController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference user = FirebaseFirestore.instance.collection('users');

  final count = 0.obs;
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

  gantiPassword(var password) async {
    var docID = null;
    await user
        .where('nik', isEqualTo: prefs.read('nik'))
        .where('no_telp', isEqualTo: prefs.read('noTelp'))
        .get()
        .then((QuerySnapshot query) {
      docID = query.docs.first.id;
      var hashPassword = sharedController.hash(password);
      user.doc(docID).update({
        'password': hashPassword,
      }).then((value) {
        Get.back();
        sharedController.showSnackbar('Berhasil', 'Password berhasil diubah');
      });
    });
  }
}
