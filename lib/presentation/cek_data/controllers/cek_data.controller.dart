import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';

class CekDataController extends GetxController {
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  final CollectionReference dtdc = FirebaseFirestore.instance.collection('DTDC');
  final CollectionReference quickCount = FirebaseFirestore.instance.collection('quick_count');

  var dataList = [].obs;
  @override
  void onInit() {
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
    if (prefs.read('role') == '1') {
      getDataRelawan();
    } else if (prefs.read('role') == '2') {
      getDataKuisioner();
    }
  }

  getDataRelawan() async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('nik_referral', isEqualTo: prefs.read('nik'))
        .get()
        .then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);

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
