import 'package:get/get.dart';

import 'wechat_logic.dart';

class WechatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WechatLogic());
  }
}
