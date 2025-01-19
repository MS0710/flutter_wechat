import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_logic.dart';
import 'package:flutter_wechat/util/im/im_group.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/util/model/contact_model.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_member_role_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';

class LaunchChatLogic extends GetxController with ContactContentLogic{
  List<String> indexBarData = [];

  RxList<ContactModel> selectItems = <ContactModel>[].obs;

  ///點擊完成時觸發
  ///如果無選擇人,則無反應
  ///如果只選擇1人,打開個人聊天
  ///選擇2人以上,打開群聊
  Future handle() async{
    if(selectItems.length == 0){
      return;
    }
    if(selectItems.length == 1){
      ChatPageModel chatPageModel = ChatPageModel(
        toId: selectItems.first.info?.userID,
        isGroup: false,
        name: ImUtil.showNameInProfile(selectItems.first.info),
      );
      Get.offNamed(AppRouters.chatSinglePage, arguments: chatPageModel,);
    }else if(selectItems.length > 1){
      final String groupName = selectItems.map((element) =>
          ImUtil.showNameInProfile(element.info)).toList().join(",");

      final List<V2TimGroupMember> members = selectItems.map((element) => V2TimGroupMember(
        userID: element.info!.userID,
        role: GroupMemberRoleTypeEnum.V2TIM_GROUP_MEMBER_ROLE_MEMBER,
      ),).toList();
      final V2TimValueCallback<String>? callback = await ImGroup.createGroup(members,groupName);
      if(callback == null){
        print("結果為空");
        return;
      }
      print("[外部]創建群聊結果::${callback?.code==0}");
      if(callback.code == 0){
        ChatPageModel chatPageModel = ChatPageModel(
          toId: callback.data,
          isGroup: true,
          name: callback.data,
        );
        Get.offNamed(AppRouters.chatGroupPage, arguments: chatPageModel,);
      }
    }

  }
}
