import 'package:get/get.dart';

import 'launch_chat_logic.dart';

class LaunchChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LaunchChatLogic());
  }
}
