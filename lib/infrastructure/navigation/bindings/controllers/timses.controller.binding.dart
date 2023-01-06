import 'package:get/get.dart';

import '../../../../presentation/timses/controllers/timses.controller.dart';

class TimsesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimsesController>(
      () => TimsesController(),
    );
  }
}
