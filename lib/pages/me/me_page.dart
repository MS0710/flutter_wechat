import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/me/personal_info_page.dart';
import 'package:flutter_wechat/pages/set/set_page.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  TextStyle wechatNumberStyle = const TextStyle(
    color: Color(0xffb7b7b7),
    fontSize: 18,
    overflow: TextOverflow.ellipsis,
  );

  List<List<String>> items = [
    ["mine_item_pay.png","服務","21","19"],
    ["mine_item_collect.png","收藏","19","20"],
    ["mine_item_picture.png","朋友圈","20","17"],
    ["mine_item_emoji.png","表情","20","20"],
    ["mine_item_setting.png","設置","20","21"],
  ];

  bool needMarginTop(String value){
    List<String> need = ["服務","收藏","設置"];
    return need.contains(value);
  }

  bool needBottomBorder(String value){
    List<String> need = ["收藏","朋友圈"];
    return need.contains(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          ClickEvent(
            onTap: (){
              Get.to(const PersonalInfoPage());
            },
            child: Container(
              height: 208,
              color: Colors.white,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                children: [
                  const SizedBox(width: 28,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: CachedNetworkImage(
                      imageUrl: MyConfig.mockAvatar,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 19,),
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyConfig.mockNickName,
                            style: const TextStyle(
                              color: Color(0xff1a1a1a),
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 3,),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "微信號: ",
                                        style: wechatNumberStyle,
                                      ),
                                      Expanded(
                                        child: Text(
                                          MyConfig.mockWechatId,
                                          style: wechatNumberStyle,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 19,),
                                child: Image.asset(
                                  "assets/images/mine_qr_code.png",
                                  width: 13,
                                  height: 13,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 24-19,right: 19,),
                                child: Image.asset(
                                  "assets/images/mine_arrow_right.png",
                                  width: 13,
                                  height: 13,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ...items.map((e) {
            return ClickEvent(
              onTap: (){
                print("當前點擊了${e.toString()}");
                if(e[1] == "設置"){
                  Get.to(const SetPage());
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: needMarginTop(e[1]) ? 9:0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18,),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/${e[0]}",
                      width: double.parse(e[2]),
                      height: double.parse(e[3]),
                    ),
                    const SizedBox(width: 19,),
                    Expanded(
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: needBottomBorder(e[1])
                                  ? const Color(0xffe5e5e5)
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e[1],
                                style: const TextStyle(
                                  color: Color(0xff181818),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/mine_arrow_right.png",
                              width: 7,
                              height: 13,
                            ),
                            const SizedBox(width: 1,),
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
  }
}
