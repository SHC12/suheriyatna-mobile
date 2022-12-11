import 'package:get/get.dart';

import '../../../../presentation/relawan/controllers/relawan.controller.dart';

class RelawanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RelawanController>(
      () => RelawanController(),
    );
  }
}
