import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_single/chat_single_view.dart';
import 'package:flutter_wechat/pages/group/group_info_page.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/chat/chat_appbar.dart';
import 'chat_group_logic.dart';

class ChatGroupPage extends StatelessWidget {
  ChatGroupPage({Key? key}) : super(key: key);

  final ChatGroupLogic logic = Get.put(ChatGroupLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: ChatAppBar(logic.chatPageModel, onMore: () => Get.to(GroupInfoPage()),),
      body: GetBuilder<ChatGroupLogic>(
        builder: (logic){
          return ChatBody(logic);
        },
      ),
    );
  }
}
