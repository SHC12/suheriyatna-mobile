import 'package:get/get.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/approval/controllers/approval.controller.dart';

class HomeController extends GetxController {
  ApprovalController approvalController = Get.put(ApprovalController());
  @override
  void onInit() {
    super.onInit();

    if (prefs.read('role') == '0') {
      approvalController.getUnVerified();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
