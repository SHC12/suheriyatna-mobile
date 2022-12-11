import 'package:get/get.dart';

import '../../../../presentation/registration/controllers/registration.controller.dart';

class RegistrationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
