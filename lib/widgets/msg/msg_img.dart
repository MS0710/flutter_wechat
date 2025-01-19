import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/me/big_avatar_page.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/pages/me/big_avatar_page.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_image.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

class MsgImg extends StatelessWidget {
  final V2TimMessage timMsg;
  const MsgImg({super.key,required this.timMsg,});

  @override
  Widget build(BuildContext context) {
    bool self = timMsg.isSelf ?? false;
    print("MsgImg::timMsg.faceUrl = ${timMsg.faceUrl}");
    print("MsgImg::timMsg.imageElem?.path = ${timMsg.imageElem?.path}");
    print("MsgImg::timMsgOfImg.url! = ${timMsg.imageElem!.imageList![1]!.url}");
    final List<Widget> bodyList = [
      const SizedBox(width: 12,),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: CachedNetworkImage(
          imageUrl: strNotEmpty(timMsg.faceUrl) ? timMsg.faceUrl! : MyConfig.mockAvatar,
          width: 41,
          height: 41,
          fit: BoxFit.cover,
        ),
      ),

      const SizedBox(width: 5,),
      Expanded(
        child: Column(
          crossAxisAlignment: self? CrossAxisAlignment.end: CrossAxisAlignment.start,
          children: [
            if(!self && (timMsg.groupID!=null))
              Text(
                timMsg.nickName ?? "",
                style: const TextStyle(
                  color: Color(0xff828282),
                  fontSize: 13,
                ),
              ),

             (){
              V2TimImage timMsgOfImg =  timMsg.imageElem!.imageList![1]!;
              V2TimImage timMsgOfImgBig =  timMsg.imageElem!.imageList![0]!;
              final double width = 100;
              final double height = width * timMsgOfImg.height!.toDouble() / timMsgOfImg.width!.toDouble();
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: ClickEvent(
                  onTap: (){
                    Get.to(BigImagePage(timMsgOfImgBig.url!));
                  },
                  child: strNotEmpty(timMsg.imageElem?.path)
                      ? Image.file(
                          File(timMsg.imageElem!.path!),
                          width: width,
                          height: height,
                        )
                      : CachedNetworkImage(
                    imageUrl: timMsgOfImg.url!,
                    width: width,
                    height: height,
                  ),
                ),
              );
            }(),
          ],
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17/2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: self ? bodyList.reversed.toList() : bodyList,
      ),
    );
  }
}
