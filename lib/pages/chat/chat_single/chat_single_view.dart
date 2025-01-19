import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/chat/chat_appbar.dart';
import 'package:flutter_wechat/widgets/chat/chat_bottom.dart';
import 'package:flutter_wechat/widgets/msg/msg_builder.dart';
import 'chat_single_logic.dart';

class ChatSinglePage extends StatelessWidget {
  ChatSinglePage({Key? key}) : super(key: key);

  final ChatSingleLogic logic = Get.put(ChatSingleLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(logic.chatPageModel, onMore: () {},),
      body: GetBuilder<ChatSingleLogic>(
        builder: (logic){
          return ChatBody(logic);
        },
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  final ChatLogic logic;
  const ChatBody(this.logic,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClickEvent(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
              if(logic.showMore) logic.showMore = false;
              logic.update();
            },
            child: Container(
              color: const Color(0xffededed),
              child: Obx((){
                return FlutterListView(
                  reverse: true,
                  delegate: FlutterListViewDelegate(
                        (context,index){
                      final msgModel = logic.msgList[index];
                      return MsgBuilder(msgModel);
                    },
                    firstItemAlign: FirstItemAlign.end,
                    childCount: logic.msgList.length,
                  ),
                );
              },),
            ),
          ),
        ),
        ChatBottom(logic: logic),
      ],
    );
  }
}

