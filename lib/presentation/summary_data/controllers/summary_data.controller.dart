import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

class SummaryDataController extends GetxController {
  SharedController sharedController = Get.put(SharedController());
  final CollectionReference timses = FirebaseFirestore.instance.collection('users');
  final CollectionReference relawan = FirebaseFirestore.instance.collection('relawan');
  final CollectionReference dtdc = FirebaseFirestore.instance.collection('DTDC');
  final CollectionReference quickCount = FirebaseFirestore.instance.collection('quick_count');
  var totalDataTimses = 0.obs;
  var totalDataRelawan = 0.obs;
  var totalDataKuisioner = 0.obs;

  var dataKuisioner = [].obs;

  var chartDataKabupaten = [].obs;
  var chartDataKabupatenRelawan = [].obs;
  var chartDataKuisioner = [].obs;

  var timsesKabupaten = [].obs;
  var relawanKabupaten = [].obs;

  dataChartKabupaten() {
    int kotaTarakanTemp = timsesKabupaten.where((p0) => p0['kabupaten'] == 'KOTA TARAKAN').toList().length;
    int kabupatenMalinauTemp = timsesKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN MALINAU').toList().length;
    int kabupatenBulunganTemp = timsesKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN BULUNGAN').toList().length;
    int kabupatenTanaTidungTemp =
        timsesKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN TANA TIDUNG').toList().length;
    int kabupatenNunukanTemp = timsesKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN NUNUKAN').toList().length;

    double kotaTarakan = kotaTarakanTemp / timsesKabupaten.length * 100;
    double kabupatenMalinau = kabupatenMalinauTemp / timsesKabupaten.length * 100;
    double kabupatenBulungan = kabupatenBulunganTemp / timsesKabupaten.length * 100;
    double kabupatenTanaTidung = kabupatenTanaTidungTemp / timsesKabupaten.length * 100;
    double kabupatenNunukan = kabupatenNunukanTemp / timsesKabupaten.length * 100;

    chartDataKabupaten.assignAll([
      {'name': 'KOTA TARAKAN', 'value': kotaTarakan},
      {'name': 'KABUPATEN MALINAU', 'value': kabupatenMalinau},
      {'name': 'KABUPATEN BULUNGAN', 'value': kabupatenBulungan},
      {'name': 'KABUPATEN TANA TIDUNG', 'value': kabupatenTanaTidung},
      {'name': 'KABUPATEN NUNUKAN', 'value': kabupatenNunukan},
    ]);
  }

  dataChartKabupatenRelawan() {
    int kotaTarakanTemp = relawanKabupaten.where((p0) => p0['kabupaten'] == 'KOTA TARAKAN').toList().length;
    int kabupatenMalinauTemp = relawanKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN MALINAU').toList().length;
    int kabupatenBulunganTemp = relawanKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN BULUNGAN').toList().length;
    int kabupatenTanaTidungTemp =
        relawanKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN TANA TIDUNG').toList().length;
    int kabupatenNunukanTemp = relawanKabupaten.where((p0) => p0['kabupaten'] == 'KABUPATEN NUNUKAN').toList().length;

    double kotaTarakan = kotaTarakanTemp / timsesKabupaten.length * 100;
    double kabupatenMalinau = kabupatenMalinauTemp / timsesKabupaten.length * 100;
    double kabupatenBulungan = kabupatenBulunganTemp / timsesKabupaten.length * 100;
    double kabupatenTanaTidung = kabupatenTanaTidungTemp / timsesKabupaten.length * 100;
    double kabupatenNunukan = kabupatenNunukanTemp / timsesKabupaten.length * 100;

    chartDataKabupatenRelawan.assignAll([
      {'name': 'KOTA TARAKAN', 'value': kotaTarakan},
      {'name': 'KABUPATEN MALINAU', 'value': kabupatenMalinau},
      {'name': 'KABUPATEN BULUNGAN', 'value': kabupatenBulungan},
      {'name': 'KABUPATEN TANA TIDUNG', 'value': kabupatenTanaTidung},
      {'name': 'KABUPATEN NUNUKAN', 'value': kabupatenNunukan},
    ]);
  }

  dataChartKuisioner() {
    int mengenalTemp = dataKuisioner.where((p0) => p0['is_mengenal'] == 'ya').toList().length;
    int tidakMengenalTemp = dataKuisioner.where((p0) => p0['is_mengenal'] == 'tidak').toList().length;

    double mengenal = mengenalTemp / dataKuisioner.length * 100;
    double tidakMengenal = tidakMengenalTemp / dataKuisioner.length * 100;

    chartDataKuisioner.assignAll([
      {'name': 'Mengenal Suheriyatna', 'value': mengenal},
      {'name': 'Tidak Mengenal Suheriyatna', 'value': tidakMengenal},
    ]);
  }

  getTotalDataTimses() async {
    await timses.get().then((QuerySnapshot query) async {
      List dataTimsesTemp = query.docs.map((e) => e.data()).toList();
      totalDataTimses.value = dataTimsesTemp.length;

      timsesKabupaten.assignAll(dataTimsesTemp);

      await dataChartKabupaten();

      print('total data timses : ${totalDataTimses.value}');
    });
  }

  getTotalDataRelawan() async {
    await relawan.get().then((QuerySnapshot query) async {
      List dataRelawanTemp = query.docs.map((e) => e.data()).toList();

      totalDataRelawan.value = dataRelawanTemp.length;
      relawanKabupaten.assignAll(dataRelawanTemp);

      await dataChartKabupatenRelawan();

      print('total data relawan : ${totalDataRelawan.value}');
    });
  }

  getTotalDataKuisioner() async {
    await dtdc.get().then((QuerySnapshot query) async {
      List dataKuisionerTemp = query.docs.map((e) => e.data()).toList();
      dataKuisioner.assignAll(dataKuisionerTemp);
      totalDataKuisioner.value = dataKuisionerTemp.length;
      dataChartKuisioner();
    });
  }
}
