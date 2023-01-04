import 'package:get/get.dart';

import '../../../../presentation/lupa_password/controllers/lupa_password.controller.dart';

class LupaPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaPasswordController>(
      () => LupaPasswordController(),
    );
  }
}
