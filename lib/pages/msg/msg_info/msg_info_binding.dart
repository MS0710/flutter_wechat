import 'package:get/get.dart';

import 'msg_info_logic.dart';

class MsgInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MsgInfoLogic());
  }
}
