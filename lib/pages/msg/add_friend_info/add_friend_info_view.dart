import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'add_friend_info_logic.dart';

class AddFriendInfoPage extends StatelessWidget {
  AddFriendInfoPage({Key? key}) : super(key: key);

  final logic = Get.find<AddFriendInfoLogic>();

  List<Widget> get addingItem{
    return [
      const SizedBox(height: 9,),
      ...logic.items.map((e) {
        return Container(
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(left: 16,),
            padding: const EdgeInsets.symmetric(vertical: 15,),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: e==logic.items.last? Colors.transparent : const Color(0xffe5e5e5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 70+18,
                  child: Text(
                    e[0],
                    style: const TextStyle(
                      color: Color(0xff1a1a1a),
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    e[1],
                    style: const TextStyle(
                      color: Color(0xff737373),
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      const SizedBox(height: 9,),
      ClickEvent(
        onTap: (){
          print("點擊了添加到通訊錄");
          Get.toNamed(AppRouters.addMsgPage,arguments: Get.arguments);
        },
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16,),
          child: const Text(
            "添加到通訊錄",
            style: TextStyle(
              color: Color(0xff576b95),
              fontSize: 17,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double avatarHeight = 64+12;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: Center(
            child: Image.asset(
              "assets/images/chat_info_arrow_left.png",
              width: 10,
            ),
          ),
        ),

        actions: [
          ClickEvent(
            onTap: (){
              print("點擊了更多");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19,),
              child: Image.asset(
                "assets/images/chat_info_more.png",
                width: 18,
              ),
            ),
          ),
        ],
      ),

      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 15,),
            child: Column(
              children: [
                const SizedBox(height: 37-17,),
                Row(
                  children: [
                    const SizedBox(width: 24-15,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6,),
                      height: avatarHeight,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl: "https://c-ssl.duitang.com/uploads/blog/202205/26/20220526144719_6be94.jpg",
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 18,),
                    Expanded(
                      child: SizedBox(
                        height: avatarHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GetBuilder<AddFriendInfoLogic>(
                                  builder: (logic){
                                    print("logic.info.value::${json.encode(logic.info.value)}");
                                    return Text(
                                      logic.info.value?.nickName??
                                          logic.info.value?.userID??
                                          "",
                                      style: const TextStyle(
                                        color: Color(0xff1a1a1a), fontSize: 20,),
                                    );
                                  },
                                  id: AddFriendInfoLogicId.nickName,
                                ),
                                const SizedBox(width: 2,),
                                Image.asset(
                                  "assets/images/chat_info_man.png",
                                  width: 15,
                                ),
                              ],
                            ),

                            const SizedBox(height: 5,),
                            const Text(
                              "地區: 中國 台灣",
                              style: TextStyle(
                                color: Color(0xff737373),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35-6,),
                Container(
                  color: const Color(0xffe5e5e5),
                  height: 1,
                  margin: const EdgeInsets.only(left: 1,),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "備註和標籤",
                      style: TextStyle(
                        color: Color(0xff1a1a1a),
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18,),
                      child: Image.asset(
                        "assets/images/chat_info_arrow_right.png",
                        width: 8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
          ...addingItem,
          //SizedBox(height: 9,),
        ],
      ),
    );
  }
}
