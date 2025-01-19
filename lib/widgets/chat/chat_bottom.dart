import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/widgets/chat/more_item_builder.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/chat/more_item_builder.dart';

class ChatBottom extends StatelessWidget {
  final ChatLogic logic;
  const ChatBottom({super.key,required this.logic,});

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 57.0;
    return SafeArea(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: itemHeight,
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 11,),
                child: Image.asset(
                  "assets/images/chat_voice.png",
                  width: 27,
                  height: 27,
                ),
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 250,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8,),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: TextField(
                    controller: logic.controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (text) => logic.sendTextMsg(),
                    onTap: (){
                      logic.showMore = false;
                      logic.update();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5,),
                    ),
                    maxLines: null,
                  ),
                ),
              ),

              Container(
                height: itemHeight,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 8,right: 11/2),
                child: Image.asset(
                  "assets/images/chat_emoji.png",
                  width: 32,
                  height: 32,
                ),
              ),
              ClickEvent(
                onTap: (){
                  logic.showMore = !logic.showMore;
                  FocusScope.of(context).requestFocus(FocusNode());
                  logic.update();
                },
                child: Container(
                  height: itemHeight,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 11,left: 11/2),
                  child: Image.asset(
                    "assets/images/chat_add.png",
                    width: 27,
                    height: 27,
                  ),
                ),
              ),
            ],
          ),

          if(logic.showMore)
            Container(
              height: 240,
              child: Stack(
                children: [
                  PageView(
                    onPageChanged: (newPageIndex){
                      logic.moreCurrentPage = newPageIndex;
                      logic.update();
                    },
                    children: (logic.moreItems.length < 8
                      ? [logic.moreItems]
                      : [
                      logic.moreItems.sublist(0,8),
                      logic.moreItems.sublist(8,logic.moreItems.length),
                      ]).map((newList){
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          margin: EdgeInsets.only(bottom: newList.length<5 ?(64+7+19+7):0),
                          child: Wrap(
                            spacing: 25,
                            runAlignment: WrapAlignment.center,
                            children: newList.map((e)=> MoreItemBuilder(
                              item: e,
                              logic: logic,
                            )).toList(),
                          ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 13,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(logic.moreItems.length>8? 2:0, (index){
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: logic.moreCurrentPage == index
                                ? const Color(0xff7b7b7b)
                                : const Color(0xffdedede),
                            shape: BoxShape.circle,
                          ),
                        );

                      },),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

  }
}
