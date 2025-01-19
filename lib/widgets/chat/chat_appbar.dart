import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

import '../../wechat_flutter.dart';

class ChatAppBar extends AppBar{
  ChatAppBar(
      Rx<ChatPageModel> chatPageModel,
  {super.key, VoidCallback? onMore,}
  ):super(
    backgroundColor: const Color(0xffededed),
    elevation: 0,
    title: Obx((){
      return Text(
        chatPageModel.value.name??"",
        style: const TextStyle(
          color: Color(0xff181818),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );
    }),

    leading: ClickEvent(
      onTap: (){
        Get.back();
      },
      child: Center(
        child: Image.asset(
          "assets/images/chat_left.png",
          width: 10,
          height: 18,
        ),
      ),
    ),
    actions: [
      ClickEvent(
        onTap: (){
          print("點擊了更多");
          if(onMore != null){
            onMore();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 19,),
          child: Image.asset(
            "assets/images/chat_more.png",
            width: 18,
            height: 4,
          ),
        ),
      ),

    ],
  );
}