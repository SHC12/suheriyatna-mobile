import 'package:get/get.dart';

import '../../../../presentation/notifikasi/controllers/notifikasi.controller.dart';

class NotifikasiControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifikasiController>(
      () => NotifikasiController(),
    );
  }
}
