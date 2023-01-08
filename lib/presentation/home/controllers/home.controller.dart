import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/approval/controllers/approval.controller.dart';

class HomeController extends GetxController {
  final CollectionReference timses = FirebaseFirestore.instance.collection('users');
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  final CollectionReference dtdc = FirebaseFirestore.instance.collection('DTDC');
  final CollectionReference quickCount = FirebaseFirestore.instance.collection('quick_count');

  var totalDataTimses = 0.obs;
  var totalDataRelawan = 0.obs;
  var totalDataKuisioner = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // getTotalDataTimses();
    // getTotalDataRelawan();
    // getTotalDataKuisioner();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getTotalDataTimses() async {
    await timses.get().then((QuerySnapshot query) async {
      List dataTimsesTemp = query.docs.map((e) => e.data()).toList();
      totalDataTimses.value = dataTimsesTemp.length;

      print('total data timses : ${totalDataTimses.value}');
    });
  }

  getTotalDataRelawan() async {
    await relawan.get().then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      totalDataRelawan.value = dataRelawanTemp.length;

      print('total data relawan : ${totalDataRelawan.value}');
    });
  }

  getTotalDataKuisioner() async {
    await dtdc.get().then((QuerySnapshot query) async {
      List dataKuisionerTemp = query.docs.map((e) => e.data()).toList();
      totalDataKuisioner.value = dataKuisionerTemp.length;

      print('total data kuisioner : ${totalDataKuisioner.value}');
    });
  }
}
