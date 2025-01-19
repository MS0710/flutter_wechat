import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/click_event.dart';

class MoreItemBuilder extends StatelessWidget {
  final List<String> item;
  final ChatLogic logic;

  const MoreItemBuilder({super.key,required this.item,required this.logic,});

  @override
  Widget build(BuildContext context) {
    return ClickEvent(
      onTap: (){
        logic.moreActions(context,item[1]);
      },
      child: SizedBox(
        width: (MediaQuery.of(context).size.width-(25*5))/4,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
              child: Image.asset(
                "assets/images/${item[0]}",
                width: double.parse(item[2]),
                height: double.parse(item[3]),
              ),
            ),
            const SizedBox(height: 7,),
            Text(
              item[1],
              style: const TextStyle(color: Color(0xff6f6f6f),fontSize: 13,),
            ),
            const SizedBox(height: 7,),
          ],
        ),
      ),
    );
  }
}
