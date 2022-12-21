import 'package:get/get.dart';

import '../../../../presentation/approval/controllers/approval.controller.dart';

class ApprovalControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApprovalController>(
      () => ApprovalController(),
    );
  }
}
