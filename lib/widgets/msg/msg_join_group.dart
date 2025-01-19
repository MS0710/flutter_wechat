import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/theme/my_theme.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

class MsgJoinGroup extends StatelessWidget {
  const MsgJoinGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13/2),
        child: Text(
          "你邀請1212,flutter模仿微信加入群聊",
          style: MyTheme.msgTimeStyle,
        ),
      ),
    );
  }
}
