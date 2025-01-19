import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/util/func/my_date.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/dialog/more_dialog.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/my_date.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/dialog/more_dialog.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

import 'wechat_logic.dart';

class WechatPage extends StatelessWidget {
  WechatPage({Key? key}) : super(key: key);
  final WechatLogic logic = Get.find<WechatLogic>();

  Widget itemBuilder(context,index){
    V2TimConversation? covItem = logic.covList[index];
    if(covItem == null){
      return Container();
    }
    return ClickEvent(
      onTap: (){
        if(strNotEmpty(covItem.groupID)){
          ChatPageModel chatPageModel = ChatPageModel(
            toId: covItem.groupID,
            isGroup: true,
            name: covItem.showName,
          );
          Get.toNamed(AppRouters.chatGroupPage,arguments: chatPageModel);
        }else{
          ChatPageModel chatPageModel = ChatPageModel(
            toId: covItem.userID,
            isGroup: false,
            name: covItem.showName,
          );
          Get.toNamed(AppRouters.chatSinglePage, arguments: chatPageModel,);
        }
      },
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 13,bottom: 12,left: 16,right: 11),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: strNotEmpty(covItem.faceUrl) ? covItem.faceUrl! : MyConfig.mockAvatar,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              if(covItem.unreadCount != null && covItem.unreadCount!=0)
                Positioned(
                  right: 11/2,
                  top: 13/2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xfffa5151),
                      borderRadius: BorderRadius.all(Radius.circular(18),),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 2,),
                    child: Text(
                      "${covItem.unreadCount ?? ""}",
                      style: const TextStyle(color: Color(0xffcfcfcf), fontSize: 12,),
                    ),
                  ),
                ),
            ],
          ),

          Expanded(
            child: Container(
              height: 72,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xffe5e5e5)),
                ),
              ),
              padding: const EdgeInsets.only(top: 13,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          covItem.showName ?? "",
                          style: const TextStyle(color: Color(0xff1a1a1a),fontSize: 16,),
                        ),
                      ),
                      Text(
                        MyDate.recentTime(covItem.lastMessage?.timestamp ?? 0),
                        //"${DateTime.fromMillisecondsSinceEpoch((covItem.lastMessage?.timestamp ?? 0)*1000).toString()}",
                        style: const TextStyle(color: Color(0xffcdcdcd),fontSize: 12,),
                      ),
                      const SizedBox(width: 16,),
                    ],
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    ImUtil.getAbstractMessageInCov(covItem.lastMessage!),
                    style: const TextStyle(color: Color(0xffb3b3b3),fontSize: 13,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffededed),
        elevation: 0,
        title: const Text(
          "微信",
          style: TextStyle(
            color: Color(0xff181818),
            fontSize: 16,
          ),
        ),
        actions: [
          Builder(
            builder: (context){
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  moreDialog(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Image.asset(
                    "assets/images/msg_more.png",
                    width: 21,
                    height: 21,
                  ),
                ),
              );
            },
          ),

        ],
      ),

      body: Column(
        children: [
          Container(
            color: const Color(0xffededed),
            width: double.infinity,
            height: 66-15,
            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 15,),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/msg_search.png",
                    width: 17,
                    height: 17,
                  ),
                  const SizedBox(width: 7,),
                  const Text(
                    "搜索",
                    style: TextStyle(
                      color: Color(0xffb3b3b3),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: GetBuilder<WechatLogic>(
              builder: (logic){
                return ListView.builder(
                  itemCount: logic.covList.length,
                  itemBuilder: itemBuilder,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
