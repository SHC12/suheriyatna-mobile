import 'package:get/get.dart';

import '../../../../presentation/shared/controllers/shared.controller.dart';

class SharedControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedController>(
      () => SharedController(),
    );
  }
}
