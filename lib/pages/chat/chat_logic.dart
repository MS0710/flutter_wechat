import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_wechat/util/bus/cov_bus.dart';
import 'package:flutter_wechat/util/bus/new_msg_bus.dart';
import 'package:flutter_wechat/util/func/my_toast.dart';
import 'package:flutter_wechat/util/im/im_msg.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/util/bus/cov_bus.dart';
import 'package:flutter_wechat/util/bus/new_msg_bus.dart';
import 'package:flutter_wechat/util/im/im_msg.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:tencent_cloud_chat_sdk/enum/message_elem_type.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_image.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_image_elem.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_text_elem.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_video_elem.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'dart:ui' as ui show Codec, FrameInfo, Image;

mixin MoreInterface{
  //圖片 label 寬度 高度
  List<List<String>> moreItems = [];
}

class ChatPageModel{
  final String? toId;
  final String? name;
  final bool isGroup;
  ChatPageModel({
    required this.toId,
    required this.isGroup,
    required this.name,
  });

  factory ChatPageModel.def(){
    return ChatPageModel(toId: "",isGroup: false,name: "");
  }
}

mixin ChatLogic on MoreInterface, GetxController{
  Rx<ChatPageModel> chatPageModel = ChatPageModel.def().obs;

  TextEditingController controller = TextEditingController();
  int moreCurrentPage = 0;
  bool showMore = false;

  ///消息列表數據
  RxList<V2TimMessage> msgList = <V2TimMessage>[].obs;
  ///新消息監聽器
  StreamSubscription? newMsgSubs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if(Get.arguments == null){
      Get.back();
      showToast("用戶異常");
      return;
    }
    chatPageModel.value = Get.arguments;
    newMsgSubs = newMsgBus.on<NewMsgBusModel>().listen((event) {
      if(event.targetId != chatPageModel.value.toId){
        return;
      }
      msgList.insert(0, event.message);
    });
    ///獲取聊天紀錄
    getMsgRecord();
    ///告訴會話列表,xx聊天窗口設置已讀
    covBus.fire(CovSetReadModel(chatPageModel.value.toId!));
    ///設置已讀
    ImMsg.setRead(chatPageModel.value);

  }

  ///獲取消息紀錄
  Future getMsgRecord() async{
    List<V2TimMessage> msgListFromApi = (await ImMsg.getMsgRecord(chatPageModel.value)) ?? [];
    msgList.value = msgListFromApi;
  }

  Future sendTextMsg() async{
    if(controller.text == ""){
      return;
    }
    V2TimMessage message = V2TimMessage(
      elemType: MessageElemType.V2TIM_ELEM_TYPE_TEXT,
      textElem: V2TimTextElem(text: controller.text),
      isSelf: true,
      timestamp: DateTime.now().millisecondsSinceEpoch ~/1000,
    );

    msgList.insert(0, message);
    print("發送消息內容::${controller.text}");
    V2TimValueCallback<V2TimMessage>? callback = await ImMsg.sendTextMsg(
      controller.text,
      toId: chatPageModel.value.toId!,
      isGroup: chatPageModel.value.isGroup,
    );
    controller.clear();
    if(callback == null){
      return;
    }
    print("發送消息是否成功::${callback.code == 0}");
    covBus.fire(CovBusModel(chatPageModel.value.toId!,message));
  }

  ///打開相機拍攝
  Future openCamera(BuildContext context) async{
    print("11");
    AssetEntity? assetEntity = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: const CameraPickerConfig(enableRecording: true,),
    );
    print("22");
    print("assetEntity是否為空::assetEntity::${assetEntity==null}");
    if(assetEntity==null){
      return;
    }
    print("文件路徑：${(await assetEntity.file)?.path}");
    sendMediaMsg(assetEntity);
  }

  ///打開相冊
  Future openPicture(BuildContext context) async{
    print("打開相冊");
    List<AssetEntity>? selectData = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        requestType: RequestType.common,
        textDelegate: AssetPickerTextDelegate(),
      ),
    );
    print("選擇了${selectData?.length ?? 0}個照片");
    if(selectData?.length == null || selectData?.length ==0){
      return;
    }
    for(AssetEntity entity in selectData!){
      sendMediaMsg(entity);
    }
  }

  Future sendMediaMsg(AssetEntity entity)async{
    File? file = await entity.file;
    if(file == null){
      return;
    }

    V2TimMessage? message;

    V2TimValueCallback<V2TimMessage>? callback;
    if(entity.type == AssetType.image){
      message = V2TimMessage(
        elemType: MessageElemType.V2TIM_ELEM_TYPE_IMAGE,
        imageElem: V2TimImageElem(
          path: file.path,
          imageList: List.generate(
            2, (index) => V2TimImage(type: null, width: entity.width, height: entity.height,),
          ),
        ),
        isSelf: true,
        timestamp: DateTime.now().millisecondsSinceEpoch ~/1000,
      );

      msgList.insert(0, message,);

      callback = await ImMsg.sendImgMsg(
        file,
        toId: chatPageModel.value.toId!,
        isGroup: chatPageModel.value.isGroup,
      );
    }else if(entity.type == AssetType.video){
      callback = await ImMsg.sendVideo(
        file,
        toId: chatPageModel.value.toId!,
        isGroup: chatPageModel.value.isGroup,
        callMsg: (String snapshotPath,int duration) async{
          Completer<ui.Image> completer = Completer<ui.Image>();

          var fileImage = Image.file(File(snapshotPath));
          fileImage.image.resolve(const ImageConfiguration()).addListener(
              ImageStreamListener((ImageInfo image,bool synchronousCall) {
                completer.complete(image.image);
              }));

          ui.Image snapshotImage = await completer.future;
          print("snapshotImage.width::${snapshotImage.width}");
          print("snapshotImage.height::${snapshotImage.height}");

          message = V2TimMessage(
            elemType: MessageElemType.V2TIM_ELEM_TYPE_VIDEO,
            isSelf: true,
            videoElem: V2TimVideoElem(
              videoPath: file.path,
              snapshotPath: snapshotPath,
              duration: duration,
              snapshotWidth: snapshotImage.width,
              snapshotHeight: snapshotImage.height,
            ),
            timestamp: DateTime.now().millisecondsSinceEpoch ~/1000,
          );
          msgList.insert(0, message!);
        }
      );
    }

    if(callback == null){
      return;
    }
    print("發送消息是否成功::${callback.code == 0}");
    covBus.fire(CovBusModel(chatPageModel.value.toId!,message!));
  }

  void moreActions(BuildContext context,String value){
    print("item[1]::$value");
    if(value == "照片"){
      openPicture(context);
    }else if(value == "拍攝"){
      openCamera(context);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    newMsgSubs?.cancel();
    newMsgSubs = null;
  }
}