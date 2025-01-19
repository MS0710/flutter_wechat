import 'package:flutter_wechat/util/im/im_group.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';

class GroupListLogic extends GetxController {
  List<V2TimGroupInfo> items = [];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
  }

  Future getData() async{
    V2TimValueCallback<List<V2TimGroupInfo>>? callback = await ImGroup.getGroupList();
    if(callback == null){
      return;
    }
    items = callback.data ?? [];
    update();
  }

}
