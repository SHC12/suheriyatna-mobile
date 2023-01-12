import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/home/home.screen.dart';
import 'package:suheriyatna_mobile/presentation/profil/data_saya.screen.dart';
import 'package:suheriyatna_mobile/presentation/profil/update_data.screen.dart';
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

  lihatData() async {
    var docID = null;
    await user
        .where('nik', isEqualTo: prefs.read('nik'))
        .where('no_telp', isEqualTo: prefs.read('noTelp'))
        .get()
        .then((QuerySnapshot query) {
      docID = query.docs.first.id;

      var dataSaya = query.docs.map((e) => e.data()).toList();
      Get.to(DataSayaScreen(
        dataSaya: dataSaya,
      ));
    });
  }

  toUpdateScreen() async {
    var docID = null;
    sharedController.loading(Get.context!);
    await sharedController.fetchKabupaten();
    await user
        .where('nik', isEqualTo: prefs.read('nik'))
        .where('no_telp', isEqualTo: prefs.read('noTelp'))
        .get()
        .then((QuerySnapshot query) async {
      docID = query.docs.first.id;

      List dataSaya = query.docs.map((e) => e.data()).toList();
      List kabupatenID = await sharedController.kabupatenList
          .where((element) => element['name'].toString() == dataSaya[0]['kabupaten'])
          .toList();

      await sharedController.fetchKecamatan(kabupatenID[0]['id']);

      List kecamatanID = await sharedController.kecamatanList
          .where((element) => element['name'].toString() == dataSaya[0]['kecamatan'])
          .toList();

      await sharedController.fetchKelurahan(kecamatanID[0]['id']);

      Get.back();
      Get.to(UpdateDataScreen(
        dataSaya: dataSaya,
      ));
    }).catchError((e) {
      Get.back();
    });
  }

  updateData(var namaLengkap, var jenisKelamin, var tempatLahir, var tglLahir, var kab, var kec, var kel, var alamat,
      var rt, var rw, var wilker, var image) async {
    var docID = null;
    sharedController.loading(Get.context!);
    await user
        .where('nik', isEqualTo: prefs.read('nik'))
        .where('no_telp', isEqualTo: prefs.read('noTelp'))
        .get()
        .then((QuerySnapshot query) async {
      docID = query.docs.first.id;
      if (image == null) {
        user.doc(docID).update({
          'nama_lengkap': namaLengkap,
          'jenis_kelamin': jenisKelamin,
          'tempat_lahir': tempatLahir,
          'tgl_lahir': tglLahir,
          'kabupaten': kab,
          'kecamatan': kec,
          'kelurahan': kel,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'wilayah_kerja': wilker,
        }).then((value) {
          prefs.write('namaLengkap', namaLengkap);
          Get.back();
          Get.offAll(() => HomeScreen());
          sharedController.showSnackbar('Berhasil', 'Data berhasil diubah');
        });
      } else {
        var urlFile = await sharedController.uploadImage(image);
        user.doc(docID).update({
          'nama_lengkap': namaLengkap,
          'jenis_kelamin': jenisKelamin,
          'tempat_lahir': tempatLahir,
          'tgl_lahir': tglLahir,
          'kabupaten': kab,
          'kecamatan': kec,
          'kelurahan': kel,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'wilayah_kerja': wilker,
          'file_pendukung': urlFile
        }).then((value) {
          prefs.write('namaLengkap', namaLengkap);
          Get.back();
          Get.offAll(() => HomeScreen());
          sharedController.showSnackbar('Berhasil', 'Data berhasil diubah');
        });
      }
    });
  }
}
