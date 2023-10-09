import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class TimsesController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  var dataList = [].obs;
  var listRelawanDeleted = [].obs;

  var totalTimsesSelected = 0.obs;
  var totalRelawan = 0.obs;

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
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('users')
          .where('is_verified', isEqualTo: true)
          .where('role', isEqualTo: '1')
          .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
          .get()
          .then((QuerySnapshot query) async {
        // List dataRelawanTemp = query.docs.map((e) => e.data()).toList();
        // dataList.assignAll(dataRelawanTemp);
        // var nikList = dataList.map((e) => e['nik']).toList();

        // await Future.forEach(nikList, (element) async {
        //   var index = nikList.indexOf(element);
        //   var a = await getTotalRelawanByTimsesReturn(element);
        //   dataList[index]["total_relawan"] = a.toString();
        // });
        // totalTimsesSelected.value = dataList.length;
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .where('is_verified', isEqualTo: true)
          .where('role', isEqualTo: '1')
          .get()
          .then((QuerySnapshot query) async {
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    }
  }

  nonAktifkanTimses(var nik) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('nik', isEqualTo: nik)
        .get()
        .then((QuerySnapshot query) async {
      var docIDTemp = query.docs.first.id;

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(docIDTemp)
      //     .update({'is_verified': false, 'is_deleted': true});
      await FirebaseFirestore.instance.collection('users').doc(docIDTemp).delete().then((value) async {
        await nonaktifRelawanByTimses(nik);
      });
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
        sharedController.showSnackbar('Berhasil', 'Timses berhasil dihapus');
      }).catchError((e) {
        Get.back();
        print('error : $e');
      });
    });
  }

  getDataTimsesByKabupaten(var kabupaten) async {
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('users')
          .where('is_deleted', isEqualTo: false)
          .where('is_verified', isEqualTo: true)
          .where('wilayah_kerja', isEqualTo: prefs.read('wilayahKerja'))
          .where('role', isEqualTo: '1')
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .where('is_deleted', isEqualTo: false)
          .where('is_verified', isEqualTo: true)
          .where('kabupaten', isEqualTo: kabupaten)
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    }
  }

  getDataTimsesByKecamatan(var kecamatan) async {
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('users')
          .where('is_deleted', isEqualTo: false)
          .where('is_verified', isEqualTo: true)
          .where('kecamatan', isEqualTo: kecamatan)
          .where('role', isEqualTo: '1')
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        totalTimsesSelected.value = dataList.length;
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    }
  }

  getDataTimsesByKelurahan(var kelurahan) async {
    if (prefs.read('role') == '00') {
      await FirebaseFirestore.instance
          .collection('users')
          .where('is_deleted', isEqualTo: false)
          .where('is_verified', isEqualTo: true)
          .where('kelurahan', isEqualTo: kelurahan)
          .where('role', isEqualTo: '1')
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
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
        var nikList = dataList.map((e) => e['nik']).toList();

        await Future.forEach(nikList, (element) async {
          var index = nikList.indexOf(element);
          var a = await getTotalRelawanByTimsesReturn(element);
          dataList[index]["total_relawan"] = a.toString();
        });
        dataList.refresh();
        log('total relawan : ${dataList}');
        // totalTimsesSelected.value = dataList.length;
      });
    }
  }

  getTotalRelawanByTimses(var nikTimses) {
    FirebaseFirestore.instance
        .collection('relawan')
        .where('nik_referral', isEqualTo: nikTimses)
        .get()
        .then((QuerySnapshot query) {
      totalRelawan.value = query.docs.length;
    });
  }

  getTotalRelawanByTimsesReturn(var nikTimses) async {
    var totalRelawanTemp = 0;
    await FirebaseFirestore.instance
        .collection('relawan')
        .where('nik_referral', isEqualTo: nikTimses)
        .get()
        .then((QuerySnapshot query) {
      totalRelawanTemp = query.docs.length;
    });

    return totalRelawanTemp;
  }

  searchTimsesByName(var name) {
    if (name == '') {
      getTimses();
    } else {
      var data = dataList
          .where((p0) => p0['nama_lengkap'].toString().toLowerCase().contains(name.toString().toLowerCase()))
          .toList();
      dataList.assignAll(data);
    }
  }
}
