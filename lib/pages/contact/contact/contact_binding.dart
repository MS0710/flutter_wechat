import 'package:get/get.dart';

import 'contact_logic.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactLogic());
  }
}
