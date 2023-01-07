import 'package:get/get.dart';

import '../../../../presentation/summary_data/controllers/summary_data.controller.dart';

class SummaryDataControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummaryDataController>(
      () => SummaryDataController(),
    );
  }
}
