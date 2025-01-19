import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/im/im_user.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import '../../../util/config/my_config.dart';

class AddFriendLogic extends GetxController {
  List<List<String>> items = [
    ["add_friend_scan.png","掃一掃","掃描二維碼名片"],
    ["add_friend_contact.png","手機聯繫人","添加通訊錄中的朋友"],
  ];

  RxBool searching = false.obs;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future searchHandle() async{
    if(controller.text == ""){
      return;
    }
    V2TimUserFullInfo? info = await ImUser.getUserFromPhone(controller.text);
    if(info == null){
      return;
    }
    print("搜索成功,可以跳轉頁面");
    print("todo:開始判斷搜索到的人是否是好友");
    Get.toNamed(AppRouters.addFriendInfoPage,arguments: info);
  }

}
