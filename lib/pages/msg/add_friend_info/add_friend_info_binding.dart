import 'package:get/get.dart';

import 'add_friend_info_logic.dart';

class AddFriendInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFriendInfoLogic());
  }
}
