import 'dart:convert';
import 'dart:developer';

import 'package:flutter_wechat/util/bus/cov_bus.dart';
import 'package:flutter_wechat/util/bus/new_msg_bus.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/util/im/im_msg.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/util/bus/cov_bus.dart';
import 'package:flutter_wechat/util/bus/new_msg_bus.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/im/im_msg.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_status.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'generate_sig.dart';

typedef IMLoginStatus(bool statusSuccess);

class ImSdk{
  static Future initSDK(IMLoginStatus imLoginStatus) async{
    print("ImSdk::initSDK()::版本號:${(await TencentImSDKPlugin.v2TIMManager.getVersion()).data}");
    print("ImSdk::initSDK()::初始化SDK");
    await TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: MyConfig.IMSdkAppID,
      loglevel: LogLevelEnum.V2TIM_LOG_ALL,
      listener: V2TimSDKListener(
        onConnecting: (){
          print("ImSdk::initSDK()::連接中");
        },
        onConnectSuccess: (){
          print("ImSdk::initSDK()::連接成功");
        },
        onConnectFailed: (int code,String error){
          print("ImSdk::initSDK()::連接失敗,錯誤代碼$code,錯誤訊息$error");
        },
        onKickedOffline: (){
          print("ImSdk::initSDK()::用戶被踢下線");
          print("todo 需要彈出提示且退出到登入頁面");
          print("");
          getCurrentLogin();
          Get.offNamedUntil(AppRouters.rootPage, (route) => false);
          showToast("用戶在其他地方登入");
        },
        onSelfInfoUpdated: (V2TimUserFullInfo info){
          print("ImSdk::initSDK()::用戶信息更新");
          print("${json.encode(info)}");
          print("");
        },
        onLog: (int logLevel,String logContent){
          print("ImSdk::initSDK()::日誌顯示");
          print("日誌級別: ${logLevel},日誌內容: ${logContent}");
          print("");
        },
        onUserSigExpired: (){
          print("ImSdk::initSDK()::用戶簽名過期");
          print("todo 需要更新簽名或者彈出提示且退出到登入頁面");
          print("");
          Fluttertoast.showToast(msg: "需要更新簽名或者彈出提示且退出到登入頁面",gravity: ToastGravity.CENTER);
        },
        onUserStatusChanged: (List<V2TimUserStatus> userStatusList){
          print("ImSdk::initSDK()::用戶狀態變更");
          print("${json.encode(userStatusList)}");
          print("");
        },
      ),
    );

    ImMsg.msgManager.addAdvancedMsgListener(listener: V2TimAdvancedMsgListener(
      onRecvNewMessage: (V2TimMessage msg){
        log("[addAdvancedMsgListener]onRecvNewMessage::${json.encode(msg)}\n");
        ///目標ID,如果是私聊就是用戶ID,否則是群聊ID
        final String targetId = strNotEmpty(msg?.userID) ? msg.userID! :msg.groupID!;
        ///聊天頁面刷新
        newMsgBus.fire(NewMsgBusModel(targetId, msg,));
        ///會話列表頁面[微信頁面,登入後的頁面]刷新
        covBus.fire(CovBusModel(targetId, msg,));
      },
    ));

    try{
      final status = await getCurrentLoginStatus();
      if(status.data == null){
        print("獲取登入狀態為空");
      }else{
        imLoginStatus(status.data == 1);
      }
    }catch(e){
      print("獲取登入狀態出線錯誤${e.toString()}");
    }
  }

  static Future login(String userID) async{
    try{
      print("ImSdk::login()::傳遞參數userID:$userID");
      final String userSig = GenerateDevUserSigForTest(
        sdkappid: MyConfig.IMSdkAppID,
        key: MyConfig.ImSdkSign,
      ).genSig(identifier: userID, expire: 99999);
      V2TimCallback loginCallback = await TencentImSDKPlugin.v2TIMManager
          .login(userID: userID, userSig: userSig);
      print("登入結果${json.encode(loginCallback.toJson())}");
      await getCurrentLogin();
      final status = await getCurrentLoginStatus();
      if(status.data == 1){
        print("登入成功,跳轉首頁");
        Get.offNamedUntil(AppRouters.rootPage, (route) => false);
      }else{
        print("登入失敗,日誌為:${loginCallback.toJson()}");
        Fluttertoast.showToast(msg: "登入失敗,${loginCallback.desc}");
      }
    }catch(e){
      print("登入出現錯誤::${e.toString()}");
      Fluttertoast.showToast(msg: "登入出現錯誤");
    }
  }

  static Future<V2TimValueCallback<String>>  getCurrentLogin() async{
    print("ImSdk::getCurrentLogin()::獲取當前登入用戶");
    V2TimValueCallback<String> callback = await TencentImSDKPlugin.v2TIMManager.getLoginUser();
    print("getCurrentLogin() :: ${callback.toJson()}");
    return callback;
  }

  static Future<V2TimValueCallback<int>> getCurrentLoginStatus() async{
    print("ImSdk::getCurrentLoginStatus()::獲取當前登入用戶狀態");
    V2TimValueCallback<int> callback = await TencentImSDKPlugin.v2TIMManager.getLoginStatus();
    print("getCurrentLoginStatus() :: ${callback.toJson()}");
    return callback;
  }

  static Future loginOut() async{
    print("ImSdk::loginOut()::登出");
    V2TimCallback callback = await TencentImSDKPlugin.v2TIMManager.logout();
    print("結果為::${json.encode(callback)}");
    if(callback.code == 0){
      print("ImSdk::loginOut()::登出成功");
      Get.offNamedUntil(AppRouters.mainPage, (route) => false);
    }else{
      print("ImSdk::loginOut()::登出失敗");
    }
  }
}