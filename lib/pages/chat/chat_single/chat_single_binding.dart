import 'package:get/get.dart';

import 'chat_single_logic.dart';

class ChatSingleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatSingleLogic());
  }
}
