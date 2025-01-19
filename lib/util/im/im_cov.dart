import 'dart:convert';
import 'dart:developer';

import 'package:tencent_cloud_chat_sdk/manager/v2_tim_conversation_manager.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class ImCov{
  static V2TIMConversationManager covManager = TencentImSDKPlugin.v2TIMManager.getConversationManager();

  ///獲取會話未讀數量
  static Future<int> getUnReadCount(String conversationID,) async{
    log("getUnReadCount()::獲取會話未讀數量::[conversationID:$conversationID]");
    try{
      V2TimValueCallback<V2TimConversation> callback = await covManager.getConversation(conversationID: conversationID);
      log("getUnReadCount()::獲取會話未讀數量::[結果:${json.encode(callback)}]");
      return callback.data?.unreadCount ?? 0;
    }catch(e){
      print("getUnReadCount()::出現錯誤::${e.toString()}");
      return 0;
    }
  }

  static Future<List<V2TimConversation?>> getCovList() async{
    print("ImCov::getCovList::獲取會話列表");
    V2TimValueCallback<V2TimConversationResult> callback = await covManager.getConversationList(nextSeq: "0", count: 100);
    print("ImCov::getCovList::獲取會話列表結果");
    print("${json.encode(callback)}");
    return callback.data?.conversationList ?? [];
  }
}