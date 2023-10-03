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
    } else if (prefs.read('role') == '00') {
      getDataRelawanKordinator();
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
        .where('kabupaten', isEqualTo: kabupaten.toString().toUpperCase())
        .get()
        .then((QuerySnapshot query) async {
      // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      // dataList.assignAll(dataRelawanTemp);
      // totalTimsesSelected.value = dataList.length;
      // print('data relawan : $dataRelawanTemp');
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

      var a = [];
      dataRelawanTemp.forEach((element) {
        if (a
            .where((elementa) =>
                element['nik'] == elementa['nik'] &&
                element['nama_lengkap'] == elementa['nama_lengkap'] &&
                element['no_telp'] == elementa['no_telp'])
            .toList()
            .isEmpty) {
          a.add(element);
        }
      });

      dataList.assignAll(a);
      totalTimsesSelected.value = dataList.length;
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
      // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      // dataList.assignAll(dataRelawanTemp);
      // totalTimsesSelected.value = dataList.length;
      // print('data relawan : $dataRelawanTemp');
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

      var a = [];
      dataRelawanTemp.forEach((element) {
        if (a
            .where((elementa) =>
                element['nik'] == elementa['nik'] &&
                element['nama_lengkap'] == elementa['nama_lengkap'] &&
                element['no_telp'] == elementa['no_telp'])
            .toList()
            .isEmpty) {
          a.add(element);
        }
      });

      dataList.assignAll(a);
      totalTimsesSelected.value = dataList.length;
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
      // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      // dataList.assignAll(dataRelawanTemp);
      // totalTimsesSelected.value = dataList.length;
      // print('data relawan : $dataRelawanTemp');
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

      var a = [];
      dataRelawanTemp.forEach((element) {
        if (a
            .where((elementa) =>
                element['nik'] == elementa['nik'] &&
                element['nama_lengkap'] == elementa['nama_lengkap'] &&
                element['no_telp'] == elementa['no_telp'])
            .toList()
            .isEmpty) {
          a.add(element);
        }
      });

      dataList.assignAll(a);
      totalTimsesSelected.value = dataList.length;
    });
  }

  getDataRelawanAll() async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('is_deleted', isEqualTo: false)
        .get()
        .then((QuerySnapshot query) async {
      // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      // dataList.assignAll(dataRelawanTemp);
      // totalTimsesSelected.value = dataList.length;
      // print('data relawan : $dataRelawanTemp');
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

      var a = [];
      dataRelawanTemp.forEach((element) {
        if (a
            .where((elementa) =>
                element['nik'] == elementa['nik'] &&
                element['nama_lengkap'] == elementa['nama_lengkap'] &&
                element['no_telp'] == elementa['no_telp'])
            .toList()
            .isEmpty) {
          a.add(element);
        }
      });

      dataList.assignAll(a);
      totalTimsesSelected.value = dataList.length;
    });
  }

  getDataRelawanKordinator() async {
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('is_deleted', isEqualTo: false)
        .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
        .get()
        .then((QuerySnapshot query) async {
      // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      // dataList.assignAll(dataRelawanTemp);
      // totalTimsesSelected.value = dataList.length;
      // print('data relawan : $dataRelawanTemp');
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

      var a = [];
      dataRelawanTemp.forEach((element) {
        if (a
            .where((elementa) =>
                element['nik'] == elementa['nik'] &&
                element['nama_lengkap'] == elementa['nama_lengkap'] &&
                element['no_telp'] == elementa['no_telp'])
            .toList()
            .isEmpty) {
          a.add(element);
        }
      });

      dataList.assignAll(a);
      totalTimsesSelected.value = dataList.length;
    });
  }

  // getDataRelawanDummy() async {
  //   await FirebaseFirestore.instance
  //       .collection('relawan')
  //       .where('file_pendukung',
  //           isEqualTo:
  //               'https://firebasestorage.googleapis.com/v0/b/suheriyatna-mobile.appspot.com/o/files%2FDefault_pfp.jpg?alt=media&token=c4f3ad6c-c673-40f3-b862-7726f2ccfcda')
  //       .get()
  //       .then((QuerySnapshot query) async {
  //     List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
  //     dataList.assignAll(dataRelawanTemp);
  //     totalTimsesSelected.value = dataList.length;
  //     print('data relawan dummy : ${dataRelawanTemp.length}');
  //   });
  // }

  getDataKuisioner() async {
    await dtdc.where('nik_relawan', isEqualTo: prefs.read('nik')).get().then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
      dataList.assignAll(dataRelawanTemp);

      print('data kuisioner : $dataRelawanTemp');
    });
  }

  searchRelawanByName(var name) {
    if (name == '') {
      getCheckData();
    } else {
      var data = dataList
          .where((p0) => p0['nama_lengkap'].toString().toLowerCase().contains(name.toString().toLowerCase()))
          .toList();
      dataList.assignAll(data);
    }
  }
}
