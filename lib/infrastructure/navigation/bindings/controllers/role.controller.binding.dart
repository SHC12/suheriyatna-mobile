import 'package:get/get.dart';

import '../../../../presentation/role/controllers/role.controller.dart';

class RoleControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleController>(
      () => RoleController(),
    );
  }
}
