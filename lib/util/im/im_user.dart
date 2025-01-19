import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class ImUser{
  static Future<V2TimUserFullInfo?> getUserFromPhone(String phone) async{
   print("ImUser::getUserFromPhone::手機號[$phone]");
   try{
     V2TimValueCallback<List<V2TimUserFullInfo>> callback =
     await TencentImSDKPlugin.v2TIMManager.getUsersInfo(userIDList: [phone]);
     print("ImUser::getUserFromPhone::結果[${json.encode(callback)}]");
     if(callback.code != 0){
       Fluttertoast.showToast(msg: ImUtil.getCodeMsg(callback.code,callback.desc),gravity: ToastGravity.CENTER);
       return null;
     }
     return callback.data?.first;
   }catch(e){
     print("getUserFromPhone::出現錯誤${e.toString()}");
     return null;
   }
  }

  static Future reqAddFriend(String userId) async{
    print("ImUser::reqAddFriend::用戶Id[$userId]");
    V2TimValueCallback<V2TimFriendOperationResult> callback = await TencentImSDKPlugin.v2TIMManager.v2TIMFriendshipManager.addFriend(
        userID: userId, addType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH);
    print("callback::result::${json.encode(callback)}");
    if(callback.code != 0){
      Fluttertoast.showToast(msg: "出現錯誤,${callback.desc}");
    }else if(callback.data?.resultCode != 0){
      Fluttertoast.showToast(
        msg: ImUtil.getCodeMsg(callback.data?.resultCode,callback.desc),
        gravity: ToastGravity.CENTER,
      );
    }else{
      showToast("申請成功");
      Get.offNamedUntil(AppRouters.rootPage,(Route<dynamic> route){
        return false;
      });
    }
  }

  static Future<List<V2TimFriendInfo>> getContact() async{
    print("ImUser::getContact::獲取通訊錄");
    V2TimValueCallback<List<V2TimFriendInfo>> callback =
    await TencentImSDKPlugin.v2TIMManager.v2TIMFriendshipManager.getFriendList();
    print("ImUser::getContact::callback::${json.encode(callback.data)}");
    return callback.data??[];
  }
}