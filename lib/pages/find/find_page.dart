import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        backgroundColor: const Color(0xffededed),
        elevation: 0,
        title: const Text(
          "發現",
          style: TextStyle(
            color: Color(0xff181818),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView(
        children: [
          ClickEvent(
            onTap: (){
              print("點擊了直播");
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18,),
              child: Row(
                children: [
                  SizedBox(
                    width: 20+(18*2),
                    child: Image.asset("assets/images/find_live.png",width: 20,height: 20,),
                  ),
                  const Expanded(
                    child: Text(
                      "直播",
                      style: TextStyle(
                        color: Color(0xff1a1a1a),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Image.asset("assets/images/find_arrow_right.png",width: 7,height: 13,),
                  const SizedBox(width: 19,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
