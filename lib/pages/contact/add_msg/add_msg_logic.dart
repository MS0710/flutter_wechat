import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/util/im/im_user.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';

class AddMsgLogic extends GetxController {
  Rx<V2TimUserFullInfo> info = V2TimUserFullInfo().obs;
  RxBool markLight = false.obs;
  final titleStyle = const TextStyle(color: Color(0xff737373), fontSize: 13,);
  final fieldStyle = const TextStyle(color: Color(0xff191919), fontSize: 16,);
  final fieldHideStyle = const TextStyle(color: Color(0xffbfbfc1), fontSize: 16,);
  final FocusNode focusNode = FocusNode();
  TextEditingController markName = TextEditingController(text: "q1",);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("打開了(申請添加好友)");
    focusNode.addListener(() {
      print("當前焦點狀態：${focusNode.hasFocus}");
      markLight.value = focusNode.hasFocus;
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("arguments:${Get.arguments}");
    if(Get.arguments == null){
      Get.back();
      showToast("用戶不存在");
      return;
    }
    info.value = Get.arguments;
  }

  Future reqAddFriend() async{
    ImUser.reqAddFriend(info.value.userID!);
  }
}
