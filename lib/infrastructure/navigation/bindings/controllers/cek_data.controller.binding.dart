import 'package:get/get.dart';

import '../../../../presentation/cek_data/controllers/cek_data.controller.dart';

class CekDataControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CekDataController>(
      () => CekDataController(),
    );
  }
}
