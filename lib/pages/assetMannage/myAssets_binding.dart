import 'package:get/get.dart';

import 'myAssets_controller.dart';

class MyAssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAssetsBinding());
  }
}
