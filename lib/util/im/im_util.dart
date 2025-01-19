import 'dart:developer';

import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/im/im_group.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/im/im_group.dart';
import 'package:tencent_cloud_chat_sdk/enum/message_elem_type.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';

class ImUtil{
  static String getCodeMsg(int? code,String? defMsg){
    if(code == null){
      return defMsg ?? "出現錯誤-";
    }
    if(code == 70107){
      return "無效的用戶ID";
    }else if(code == 30001){
      return "用戶已經存在";
    }else if(code == 6017){
      return "無效的群名字";
    }else if(code == 10058){
      return "群聊上限,請檢查IM後台";
    } else{
      return defMsg ?? "出現錯誤";
    }
  }

  static String showNameInProfile(V2TimFriendInfo? info){
    return info?.friendRemark ??
        info?.userProfile?.nickName ??
        info?.userID ??
        "";
  }

  /// 获取message的抽象信息，用于replyMessage
  static String getAbstractMessageInCov(V2TimMessage? message) {
    if(message == null){
      return "";
    }
    final elemType = message.elemType;
    switch (elemType) {
      case MessageElemType.V2TIM_ELEM_TYPE_FACE:
        return "[表情消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_CUSTOM:
        return "[自定義消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_FILE:
        return "[文件消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_GROUP_TIPS:
        return "[群消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_IMAGE:
        return "[圖片消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_LOCATION:
        return "[位置消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_MERGER:
        return "[合併消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_NONE:
        return "[沒有元素]";
      case MessageElemType.V2TIM_ELEM_TYPE_SOUND:
        return "[語音消息]";
      case MessageElemType.V2TIM_ELEM_TYPE_TEXT:
        return message.textElem?.text ?? "";
      case MessageElemType.V2TIM_ELEM_TYPE_VIDEO:
        return "[視頻消息]";
      default:
        return "";
    }
  }

  ///消息實體轉換成會話列表ID
  static String msgToCovId(V2TimMessage message){
    if(strNotEmpty(message.groupID)){
      return "group_${message.groupID}";
    }else{
      return "c2c_${message.userID}";
    }
  }

  ///消息實體轉換成顯示的名字
  static Future<String> msgToShowName(V2TimMessage message) async{
    if(strNotEmpty(message.groupID)){
      try{
        V2TimValueCallback<List<V2TimGroupInfoResult>> callback = await ImGroup.getGroupInfo(message.groupID!);
        if(strNotEmpty(callback.data?.first.groupInfo?.groupName)){
          return callback.data!.first.groupInfo!.groupName!;
        }else{
          return message.groupID ?? "";
        }
      }catch(e){
        log("msgToShowName()出現錯誤::${e.toString()}");
        return message.groupID ?? "";
      }
    }else{
      return strNotEmpty(message.friendRemark)
          ? message.friendRemark!
          : strNotEmpty(message.nickName)
            ? message.nickName!
            : message.userID!;
    }
  }

}