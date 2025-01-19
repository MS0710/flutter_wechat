import 'package:get/get.dart';

import 'chat_group_logic.dart';

class ChatGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatGroupLogic());
  }
}
