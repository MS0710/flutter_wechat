import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/theme/my_theme.dart';
import 'package:flutter_wechat/util/theme/my_theme.dart';


class MsgTime extends StatelessWidget {
  const MsgTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25-17),
        child: Text(
          "15:32",
          style: MyTheme.msgTimeStyle,
        ),
      ),
    );
  }
}
