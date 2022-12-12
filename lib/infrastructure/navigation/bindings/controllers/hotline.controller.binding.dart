import 'package:get/get.dart';

import '../../../../presentation/hotline/controllers/hotline.controller.dart';

class HotlineControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotlineController>(
      () => HotlineController(),
    );
  }
}
