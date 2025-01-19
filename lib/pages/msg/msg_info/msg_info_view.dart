import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/im/im_util.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'msg_info_logic.dart';

class MsgInfoPage extends StatelessWidget {
  MsgInfoPage({Key? key}) : super(key: key);

  final MsgInfoLogic logic = Get.find<MsgInfoLogic>();

  List<Widget> get notAddingItem{
    return logic.itemsOfNotAdding.map((e) {
      return ClickEvent(
        onTap: () async{
          if(e[1] == "發信息"){
            ChatPageModel chatPageModel = ChatPageModel(
              toId: logic.info?.userID,
              isGroup: false,
              name: ImUtil.showNameInProfile(logic.info),
            );

            Get.toNamed(AppRouters.chatSinglePage, arguments: chatPageModel,);
            print("發信息:當前時間:${DateTime.now()}");
          }else if(e[1] == "音視頻通話"){
            print("音視頻通話:當前時間:${DateTime.now()}");
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17,),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                    color: e==logic.itemsOfNotAdding.last ? Colors.transparent : const Color(0xffe5e5e5),
                    width: 1,
                  )
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/${e[0]}",
                width: double.parse(e[2]),
                height: double.parse(e[3]),
              ),
              const SizedBox(width: 7,),
              Text(
                e[1],
                style: const TextStyle(
                  color: Color(0xff576b95),
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
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
            child: GetBuilder<MsgInfoLogic>(
              builder: (logic){
                return Column(
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
                              imageUrl: MyConfig.mockAvatar,
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
                                    Text(
                                      ImUtil.showNameInProfile(logic.info),
                                      style: const TextStyle(
                                        color: Color(0xff1a1a1a),
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 2,),
                                    Image.asset(
                                      "assets/images/chat_info_man.png",
                                      width: 15,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 5,),
                                Text(
                                  "微信號:${logic.info?.userID ?? ""}",
                                  style: const TextStyle(
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
                          "備註好友暱稱",
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
                );
              },
            ),
          ),
          const SizedBox(height: 9,),
          ...notAddingItem,
        ],
      ),
    );
  }
}
