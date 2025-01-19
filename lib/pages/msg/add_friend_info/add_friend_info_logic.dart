import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';

enum AddFriendInfoLogicId{
  nickName,
}

class AddFriendInfoLogic extends GetxController {
  Rx<V2TimUserFullInfo> info = V2TimUserFullInfo().obs;
  List<List<String>> items = [
    ["個性簽名","乾坤未定,你我皆黑馬,Stay young and stay hungry"],
    ["來源","來自帳號搜索"]
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    try{
      print("arguments:${Get.arguments}");
      if(Get.arguments == null){
        Get.back();
        showToast("用戶不存在");
        return;
      }
      info.value = Get.arguments;
      update([AddFriendInfoLogicId.nickName]);
      print("更新了::${AddFriendInfoLogicId.nickName.toString()}");
    }catch(e){
      print("出現錯誤${e.toString()}");
    }
  }
}
