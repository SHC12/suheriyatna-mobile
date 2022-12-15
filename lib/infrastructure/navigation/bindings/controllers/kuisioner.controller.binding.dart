import 'package:get/get.dart';

import '../../../../presentation/kuisioner/controllers/kuisioner.controller.dart';

class KuisionerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KuisionerController>(
      () => KuisionerController(),
    );
  }
}
