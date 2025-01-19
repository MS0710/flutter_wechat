import 'dart:convert';
import 'dart:io';

import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:tencent_cloud_chat_sdk/enum/receive_message_opt_enum.dart';
import 'package:tencent_cloud_chat_sdk/manager/v2_tim_message_manager.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

typedef CallVideoMsg(String snapshotPath,int duration);

class ImMsg{
  static V2TIMMessageManager msgManager = TencentImSDKPlugin.v2TIMManager.v2TIMMessageManager;

  static Future<V2TimValueCallback<V2TimMessage>?> sendTextMsg(String text,
      {required String toId,required bool isGroup,}) async{
    print("ImMsg::sendTextMsg::text::$text,toId::$toId,isGroup::$isGroup");
    V2TimValueCallback<V2TimMsgCreateInfoResult> result = await msgManager.createTextMessage(text: text);

    if(result.data == null){
      print("創建失敗::${result.data == null}");
      showToast("出現錯誤");
      return null;
    }
    print("創建消息成功,ID為${result.data!.id!}");
    V2TimValueCallback<V2TimMessage> callback = await msgManager.sendMessage(
      id: result.data!.id!,
      receiver: isGroup ? "" : toId,
      groupID: !isGroup ? "" : toId,
    );
    print("發送消息結果::${json.encode(callback)}");
    return callback;
  }

  //獲取消息紀錄
  static Future<List<V2TimMessage>?> getMsgRecord(ChatPageModel chatPageModel) async{
    print("ImMsg::getMsgRecord::獲取消息紀錄,參數userID=${chatPageModel.toId},是否群聊isGroup=${chatPageModel.isGroup}");
    try{
      V2TimValueCallback<List<V2TimMessage>> result;
      if(chatPageModel.isGroup){
        result = await msgManager.getGroupHistoryMessageList(groupID: chatPageModel.toId!, count: 50);
      }else{
        result = await msgManager.getC2CHistoryMessageList(userID: chatPageModel.toId!, count: 50);
      }
      print("獲取消息紀錄結果::${json.encode(result)}");
      return result.data;
    }catch(e){
      print("getMsgRecord::出現了錯誤::${e.toString()}");
      return null;
    }
  }

  static Future<V2TimValueCallback<V2TimMessage>?> sendImgMsg(File file,
      {required String toId,required bool isGroup,}) async{
    print("開始發送圖片消息");
    if(!file.existsSync()){
      print("圖片不存在");
      return null;
    }
    V2TimValueCallback<V2TimMsgCreateInfoResult> result = await msgManager.createImageMessage(imagePath: file.path);
    if(result.data == null){
      print("創建失敗::${result.data == null}");
      showToast("出現錯誤");
      return null;
    }
    print("創建消息成功,ID為${result.data!.id!}");
    V2TimValueCallback<V2TimMessage> callback = await msgManager.sendMessage(
      id: result.data!.id!,
      receiver: isGroup ? "" : toId,
      groupID: !isGroup ? "" : toId,
    );
    print("發送消息結果::${json.encode(callback)}");
    return callback;
  }

  ///發送視頻消息
  static Future<V2TimValueCallback<V2TimMessage>?> sendVideo(File file,
      {required String toId,required bool isGroup,required CallVideoMsg callMsg,}) async{
    print("開始發送視頻消息");
    if(!file.existsSync()){
      print("視頻不存在");
      return null;
    }
    String videoFilePath = file.path;
    print("videoFilePath::$videoFilePath");
    String type = videoFilePath.split(".").last;
    print("type::$type");
    int duration = (await FlutterVideoInfo().getVideoInfo(videoFilePath))!.duration! ~/ 1000;
    print("duration::$duration");
    String? snapshotPath = await VideoThumbnail.thumbnailFile(video: videoFilePath);
    print("snapshotPath::$snapshotPath");

    if(!strNotEmpty(snapshotPath)){
      showToast("獲取視頻封面失敗");
      return null;
    }
    callMsg(snapshotPath!,duration);

    V2TimValueCallback<V2TimMsgCreateInfoResult> result =
      await msgManager.createVideoMessage(
        videoFilePath: videoFilePath,
        type: type,
        duration: duration,
        snapshotPath: snapshotPath,
      );

    if(result.data == null){
      print("創建失敗::${result.data == null}");
      showToast("出現錯誤");
      return null;
    }
    print("創建消息成功,ID為${result.data!.id!}");
    V2TimValueCallback<V2TimMessage> callback = await msgManager.sendMessage(
      id: result.data!.id!,
      receiver: isGroup ? "" : toId,
      groupID: !isGroup ? "" : toId,
    );
    print("發送消息結果::${json.encode(callback)}");
    return callback;
  }

  ///修改消息接收選項
  static Future setReceiveMessageOpt(ChatPageModel chatPageModel)async{
    print("ImMsg::setReceiveMessageOpt::修改消息接收選項,[toId:${chatPageModel.toId}]");
    if(chatPageModel.isGroup){
      msgManager.setGroupReceiveMessageOpt(
        groupID: chatPageModel.toId!,
        opt: ReceiveMsgOptEnum.V2TIM_RECEIVE_MESSAGE,
      );
    }else{
      msgManager.setC2CReceiveMessageOpt(
        userIDList: [chatPageModel.toId!,],
        opt: ReceiveMsgOptEnum.V2TIM_RECEIVE_MESSAGE,
      );
    }
  }

  static Future setRead(ChatPageModel chatPageModel)async{
    print("ImMsg::setRead::設置已讀,[toId:${chatPageModel.toId}]");
    V2TimCallback callback;
    if(chatPageModel.isGroup){
      callback = await msgManager.markGroupMessageAsRead(groupID: chatPageModel.toId!,);
    }else{
      callback = await msgManager.markC2CMessageAsRead(userID: chatPageModel.toId!,);
    }
    print("ImMsg::setRead::設置已讀,[結果:${json.encode(callback)}]");

  }
}