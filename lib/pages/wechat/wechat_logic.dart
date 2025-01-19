import 'dart:async';

import 'package:flutter_wechat/util/bus/cov_bus.dart';
import 'package:flutter_wechat/util/im/im_cov.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/util/bus/cov_bus.dart';
import 'package:flutter_wechat/util/im/im_cov.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';


class WechatLogic extends GetxController {
  List<V2TimConversation?> covList = [];
  StreamSubscription? covBusValue;
  StreamSubscription? covSetReadBusValue;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("微信頁面範例初始化");
    covBusValue = covBus.on<CovBusModel>().listen((event) async{
      print("會話列表監聽到了事件");
      V2TimConversation? whereItem = covList.firstWhere((element) =>
        element?.userID==event.targetId ||
        element?.groupID==event.targetId);
      V2TimMessage newMsg = event.message;
      String conversationID = ImUtil.msgToCovId(newMsg);
      await Future.delayed(const Duration(milliseconds: 200));
      int unreadCount = (await ImCov.getUnReadCount(conversationID));
      if(whereItem==null){
        covList.insert(0, V2TimConversation(
          conversationID: conversationID,
          groupID: newMsg.groupID,
          userID: newMsg.userID,
          faceUrl: newMsg.faceUrl,
          unreadCount: 0,
          showName: await ImUtil.msgToShowName(newMsg),
          lastMessage: newMsg,
        ));
      }else{
        final int whereIndex = covList.indexOf(whereItem);
        covList[whereIndex]!.lastMessage = newMsg;
        covList[whereIndex]!.unreadCount = unreadCount;
      }
      update();
    });

    covSetReadBusValue = covBus.on<CovSetReadModel>().listen((event) async{
      V2TimConversation? whereItem = covList.firstWhere((element) =>
      element?.userID==event.targetId ||
          element?.groupID==event.targetId);
      final int whereIndex = covList.indexOf(whereItem);
      covList[whereIndex]!.unreadCount = 0;
      update();
    });
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    covBusValue?.cancel();
    covBusValue = null;
    covSetReadBusValue?.cancel();
    covSetReadBusValue = null;
  }

  Future getData() async{
    covList = await ImCov.getCovList();
    update();
  }

}
