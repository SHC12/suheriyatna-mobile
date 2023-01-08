import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class TimsesController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  var dataList = [].obs;
  var listRelawanDeleted = [].obs;

  var totalTimsesSelected = 0.obs;
  @override
  void onInit() {
    super.onInit();
    sharedController.fetchKabupaten();
    getTimses();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getTimses() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('is_verified', isEqualTo: true)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);
      totalTimsesSelected.value = dataList.length;
      print('data relawan : $dataRelawanTemp');
    });
  }

  nonAktifkanTimses(var nik) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('nik', isEqualTo: nik)
        .get()
        .then((QuerySnapshot query) async {
      var docIDTemp = query.docs.first.id;

      await FirebaseFirestore.instance.collection('users').doc(docIDTemp).update({'is_verified': false});
      nonaktifRelawanByTimses(nik);
    });
  }

  nonaktifRelawanByTimses(var nik) async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('nik_referral', isEqualTo: nik)
        .get()
        .then((QuerySnapshot query) async {
      List listRelawanTemp = query.docs.map((e) => e.data()).toList();

      listRelawanTemp.forEach((element) {
        element['id'] = query.docs[listRelawanTemp.indexOf(element)].id;
      });

      listRelawanDeleted.assignAll(query.docs.map((e) => e.id).toList());

      await Future.forEach(listRelawanDeleted, (element) {
        FirebaseFirestore.instance.collection('relawan').doc(element.toString()).update({'is_deleted': true});
      }).then((value) async {
        await getTimses();
        Get.back();
        Get.back();
        sharedController.showSnackbar('Berhasil', 'Timses berhasil dinonaktifkan');
      }).catchError((e) {
        Get.back();
        print('error : $e');
      });
    });
  }

  getDataTimsesByKabupaten(var kabupaten) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('is_deleted', isEqualTo: false)
        .where('is_verified', isEqualTo: true)
        .where('kabupaten', isEqualTo: kabupaten)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);

      totalTimsesSelected.value = dataList.length;

      print('data relawan : $dataRelawanTemp');
    });
  }

  getDataTimsesByKecamatan(var kecamatan) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('is_deleted', isEqualTo: false)
        .where('is_verified', isEqualTo: true)
        .where('kecamatan', isEqualTo: kecamatan)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);
      totalTimsesSelected.value = dataList.length;
      print('data relawan : $dataRelawanTemp');
    });
  }

  getDataTimsesByKelurahan(var kelurahan) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('is_deleted', isEqualTo: false)
        .where('is_verified', isEqualTo: true)
        .where('kelurahan', isEqualTo: kelurahan)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);
      totalTimsesSelected.value = dataList.length;
      print('data relawan : $dataRelawanTemp');
    });
  }
}
