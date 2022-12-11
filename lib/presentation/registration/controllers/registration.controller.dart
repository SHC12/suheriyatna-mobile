import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:suheriyatna_mobile/infrastructure/dal/services/network_service.dart';
import 'package:suheriyatna_mobile/infrastructure/dal/services/url_list_service.dart';
import 'package:suheriyatna_mobile/presentation/registration/registration_complete.screen.dart';

class RegistrationController extends GetxController {
  NetworkService networkService = Get.put(NetworkService());

  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');

  var kabupatenList = [].obs;
  var kecamatanList = [].obs;
  var kelurahanList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKabupaten();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  registrasiRelawan(
      var nik,
      var namaLengkap,
      var tempatLahir,
      var tanggalLahir,
      var jenisKelamin,
      var golDarah,
      var kabupaten,
      var kecamatan,
      var kelurahan,
      var alamat,
      var rtRW,
      var pekerjaan,
      var email,
      var kodeReferral,
      var noTelp) async {
    await relawan.add({
      'my_refferal_code': randomAlpha(6),
      'nik': nik,
      'nama_lengkap': namaLengkap,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir,
      'jenis_kelamin': jenisKelamin,
      'gol_darah': golDarah,
      'kabupaten': kabupaten,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'alamat': alamat,
      'rt_rw': rtRW,
      'pekerjaan': pekerjaan,
      'email': email,
      'kode_referral': kodeReferral,
      'no_telp': noTelp,
    });

    Get.offAll(RegistrationCompleteScreen());
  }

  checkNIK(var nik) async {
    await relawan.where('nik', isEqualTo: nik).get().then((QuerySnapshot query) {
      if (query.docs.length > 0) {
        print('NIK sudah terdaftar');
      } else {
        print('NIK belum terdaftar');
      }
    });
  }

  fetchKabupaten() async {
    kabupatenList.clear();
    return networkService.get(
        path: UrlListService.urlKabupaten,
        onSuccess: (content) {
          kabupatenList.assignAll(content);
          print(content);
        },
        onError: (content) {
          print(content);
        });
  }

  fetchKecamatan(var idKabupaten) async {
    kecamatanList.clear();
    return networkService.get(
        path: '${UrlListService.urlKecamatan + idKabupaten}.json',
        onSuccess: (content) {
          kecamatanList.assignAll(content);
          print('kecamatan : $content');
        },
        onError: (content) {
          print('kecamatan : $content');
        });
  }

  fetchKelurahan(var idKecamatan) async {
    kelurahanList.clear();
    return networkService.get(
        path: '${UrlListService.urlKelurahan + idKecamatan}.json',
        onSuccess: (content) {
          kelurahanList.assignAll(content);
          print('kelurahan : $content');
        },
        onError: (content) {
          print('kelurahan : $content');
        });
  }
}
