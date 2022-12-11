import 'package:get/get.dart';

import '../../../../presentation/profil/controllers/profil.controller.dart';

class ProfilControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(
      () => ProfilController(),
    );
  }
}
