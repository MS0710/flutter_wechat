import 'package:flutter/material.dart';
import 'package:flutter_wechat/widgets/msg/msg_img.dart';
import 'package:flutter_wechat/widgets/msg/msg_join_group.dart';
import 'package:flutter_wechat/widgets/msg/msg_text.dart';
import 'package:flutter_wechat/widgets/msg/msg_time.dart';
import 'package:flutter_wechat/widgets/msg/msg_video.dart';
import 'package:flutter_wechat/widgets/msg/msg_img.dart';
import 'package:flutter_wechat/widgets/msg/msg_join_group.dart';
import 'package:flutter_wechat/widgets/msg/msg_text.dart';
import 'package:flutter_wechat/widgets/msg/msg_time.dart';
import 'package:flutter_wechat/widgets/msg/msg_video.dart';
import 'package:tencent_cloud_chat_sdk/enum/message_elem_type.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

class MsgBuilder extends StatelessWidget {
  final V2TimMessage timMsg;
  const MsgBuilder(this.timMsg,{super.key,});

  @override
  Widget build(BuildContext context) {
    if(timMsg.elemType == MessageElemType.V2TIM_ELEM_TYPE_TEXT){
      return MsgText(timMsg: timMsg,);
    }else if(timMsg.elemType == MessageElemType.V2TIM_ELEM_TYPE_GROUP_TIPS){
      return MsgJoinGroup();
    }else if(timMsg.elemType == MessageElemType.V2TIM_ELEM_TYPE_CUSTOM &&
        timMsg.customElem?.extension == "DateTime"){
      return MsgTime();
    }else if(timMsg.elemType == MessageElemType.V2TIM_ELEM_TYPE_IMAGE){
      return MsgImg(timMsg: timMsg,);
    }else if(timMsg.elemType == MessageElemType.V2TIM_ELEM_TYPE_VIDEO){
      return MsgVideo(timMsg: timMsg,);
    }
    return const Placeholder();
  }
}
