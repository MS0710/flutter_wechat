import 'dart:convert';
import 'dart:developer';

import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_add_opt_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_type.dart';
import 'package:tencent_cloud_chat_sdk/manager/v2_tim_group_manager.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class ImGroup{
  static V2TIMGroupManager manager = TencentImSDKPlugin.v2TIMManager.v2TIMGroupManager;

  static Future<V2TimValueCallback<List<V2TimGroupInfoResult>>> getGroupInfo(String groupID)async{
    print("ImGroup::getGroupInfo::groupID${json.encode(groupID)}");
    V2TimValueCallback<List<V2TimGroupInfoResult>> callback =
    await ImGroup.manager.getGroupsInfo(groupIDList: [groupID]);
    log("getGroupInfo()::獲取群聊訊息::[結果:${json.encode(callback)}]");
    return callback;
  }

  static Future<V2TimValueCallback<String>?> createGroup(
      List<V2TimGroupMember> memberList,String groupName) async{

    print("ImGroup::createGroup::memberList${json.encode(memberList)},groupName::${groupName}");
    V2TimValueCallback<String> callback = await manager.createGroup(
      groupType: GroupType.Public,
      groupName: groupName.length>10 ? groupName.substring(0,9)+"...":groupName,
      addOpt: GroupAddOptTypeEnum.V2TIM_GROUP_ADD_ANY,
      memberList: memberList,
    );
    print("ImGroup::createGroup::創建群聊結果::${json.encode(callback)}");
    if(callback.code !=0){
      showToast(ImUtil.getCodeMsg(callback.code,callback.desc));
      return null;
    }
    return callback;
  }

  ///獲取群聊列表
  static Future<V2TimValueCallback<List<V2TimGroupInfo>>?> getGroupList() async{
    print("ImGroup::getGroupList::獲取群聊列表");
    V2TimValueCallback<List<V2TimGroupInfo>> callback = await manager.getJoinedGroupList();
    print("ImGroup::getGroupList::獲取群聊列表::${json.encode(callback)}");
    if(callback.code != 0){
      showToast(ImUtil.getCodeMsg(callback.code, callback.desc));
      return null;
    }
    return callback;
  }
}