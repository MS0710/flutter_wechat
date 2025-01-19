import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/util/im/im_sdk.dart';

class SetPage extends StatefulWidget {
  const SetPage({super.key});

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {

  Future loginOut() async{
    ImSdk.loginOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: Text("退出登入"),
          onPressed: () async{
            avoidRepeatingEvent(() async{
              print("退出登入${DateTime.now()}");
              loginOut();
            });
          },
        ),
      ),
    );
  }
}
