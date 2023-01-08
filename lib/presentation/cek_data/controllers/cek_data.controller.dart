import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';

import '../../shared/controllers/shared.controller.dart';

class CekDataController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  final CollectionReference dtdc = FirebaseFirestore.instance.collection('DTDC');
  final CollectionReference quickCount = FirebaseFirestore.instance.collection('quick_count');
  var totalTimsesSelected = 0.obs;

  var dataList = [].obs;
  @override
  void onInit() {
    // sharedController.fetchKabupaten();
    getCheckData();
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

  getCheckData() {
    print(prefs.read('role'));
    print(prefs.read('nik'));
    if (prefs.read('role') == '1') {
      getDataRelawan();
    } else if (prefs.read('role') == '2') {
      getDataKuisioner();
    } else if (prefs.read('role') == '0') {
      getDataRelawanAll();
    }
  }

  getDataRelawan() async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('nik_referral', isEqualTo: prefs.read('nik'))
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);
      totalTimsesSelected.value = dataList.length;

      print('data relawan : $dataRelawanTemp');
    });
  }

  getDataRelawanByKabupaten(var kabupaten) async {
    await FirebaseFirestore.instance
        .collection('relawan')
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

  getDataRelawanByKecamatan(var kecamatan) async {
    await FirebaseFirestore.instance
        .collection('relawan')
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

  getDataRelawanByKelurahan(var kelurahan) async {
    await FirebaseFirestore.instance
        .collection('relawan')
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

  getDataRelawanAll() async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);
      totalTimsesSelected.value = dataList.length;
      print('data relawan : $dataRelawanTemp');
    });
  }

  getDataKuisioner() async {
    await dtdc.where('nik_relawan', isEqualTo: prefs.read('nik')).get().then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);

      print('data kuisioner : $dataRelawanTemp');
    });
  }
}
