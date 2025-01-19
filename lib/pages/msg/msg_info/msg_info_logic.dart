import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';

class MsgInfoLogic extends GetxController {
  V2TimFriendInfo? info;
  List<List<String>> itemsOfNotAdding = [
    ["chat_info_send_msg.png","發信息","17","16"],
    ["chat_info_video_call.png","音視頻通話","19","12"],
  ];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if(Get.arguments == null){
      Get.back();
      showToast("用戶異常");
      return;
    }
    info = Get.arguments;
    update();
  }
}
