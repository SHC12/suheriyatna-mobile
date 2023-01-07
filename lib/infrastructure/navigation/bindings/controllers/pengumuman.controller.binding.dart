import 'package:get/get.dart';

import '../../../../presentation/pengumuman/controllers/pengumuman.controller.dart';

class PengumumanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengumumanController>(
      () => PengumumanController(),
    );
  }
}
