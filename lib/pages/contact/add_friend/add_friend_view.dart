import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

import '../../../util/func/func.dart';
import '../../me/qr_code_page.dart';
import 'add_friend_logic.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({Key? key}) : super(key: key);

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final AddFriendLogic logic = Get.put(AddFriendLogic());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xffededed),
        appBar: logic.searching.value
            ? null
            : AppBar(
          backgroundColor: const Color(0xffededed),
          elevation: 0,
          leading: ClickEvent(
            onTap: (){
              Get.back();
            },
            child: Center(
              child: Image.asset(
                "assets/images/add_friend_arrow_left.png",
                width: 10,
                height: 18,
              ),
            ),
          ),
          title: const Text(
            "添加朋友",
            style: TextStyle(
              color: Color(0xff181818),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        body: logic.searching.value
            ? SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8,),
                  padding: const EdgeInsets.only(left: 11,),
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/add_friend_search.png",
                        width: 17,
                        height: 17,
                      ),
                      const SizedBox(width: 9,),
                      Expanded(
                        child: TextField(
                          controller: logic.controller,
                          focusNode: logic.focusNode,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (text){
                            print("搜索內容:$text");
                            logic.searchHandle();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide.none,),
                            contentPadding: EdgeInsets.symmetric(vertical: 5,),
                            hintText: "帳號/手機號",
                            hintStyle: TextStyle(
                              color: Color(0xffb3b3b3),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClickEvent(
                onTap: (){
                  logic.searching.value = false;
                  //setState(() {});
                },
                child: Container(
                  width: 12+10+33,
                  height: 36,
                  alignment: Alignment.center,
                  child: const Text(
                    "取消",
                    style: TextStyle(
                      color: Color(0xff7D909A),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            ],
          ),
        )
            : ListView(
          children: [
            ClickEvent(
              onTap: (){
                logic.searching.value = true;
                logic.focusNode.requestFocus();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 8,right: 8,bottom: 17,top: 6,),
                padding: const EdgeInsets.symmetric(vertical: 9,),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6),),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/add_friend_search.png",
                      width: 17,
                    ),
                    const SizedBox(width: 13,),
                    const Text(
                      "帳號/手機號",
                      style: TextStyle(color: Color(0xffb3b3b3),fontSize: 16,),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "我的微信號：1234567987965",
                  style: TextStyle(color: Color(0xff181818),fontSize: 14,),
                ),
                ClickEvent(
                  onTap: (){
                    Get.to(const QrCodePage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    child: Image.asset(
                      "assets/images/add_friend_qr_code.png",
                      width: 17,
                      height: 17,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32,),
            ...logic.items.map((e) {
              return ClickEvent(
                onTap: (){
                  if(e[1] == "掃一掃"){
                    Func.scan();
                  }else{
                    print("${e[1]}::Coming soon");
                  }
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 16,),
                  child: Row(
                    children: [
                      Image.asset(
                        ("assets/images/${e[0]}"),
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15,),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: e == logic.items.last
                                      ? Colors.transparent
                                      : const Color(0xffe5e5e5),
                                  width: 1
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e[1],
                                      style: const TextStyle(color: Color(0xff1a1a1a),fontSize: 16,),
                                    ),
                                    Text(
                                      e[2],
                                      style: const TextStyle(color: Color(0xff1a1a1a),fontSize: 16,),
                                    ),
                                  ],
                                ),
                              ),

                              Image.asset(
                                "assets/images/add_friend_arrow_right.png",
                                width: 8,
                                height: 13,
                              ),
                              const SizedBox(width: 18,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      );
    });
  }
}
