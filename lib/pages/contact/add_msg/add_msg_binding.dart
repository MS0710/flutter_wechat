import 'package:get/get.dart';

import 'add_msg_logic.dart';

class AddMsgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMsgLogic());
  }
}
