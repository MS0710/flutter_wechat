import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

class GroupInfoPage extends StatefulWidget {
  const GroupInfoPage({super.key});

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  List<String> items = [
    "群聊名稱",
    "群二維碼",
    "群公告",
    "群管理",
    "備註",
    "查找聊天內容",
    "消息免打擾",
    "置頂聊天",
    "保存到通訊錄",
    "設置當前聊天背景",
    "清空聊天訊息",
    "投訴",
  ];

  @override
  Widget build(BuildContext context) {
    final double spaceRowItem = (4*20)+46;
    final double realWidth = (MediaQuery.of(context).size.width - spaceRowItem)/5;
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "聊天信息(3)",
          style: TextStyle(
            color: Color(0xff181818),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: Center(
            child: Image.asset(
              "assets/images/group_info_back.png",
              width: 10,
              height: 18,
            ),
          ),
        ),
      ),

      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 23,right: 23,top: 30-17,bottom: 13,),
            child: Wrap(
              spacing: 20,
              runSpacing: 14,
              children: [
                "往事如風",
                "Flutterasa",
                "代碼邊界",
                "符合",
                "上午好別墅",
                "上午2好別墅",
              ].map<Widget>((e) {
                return SizedBox(
                  width: realWidth,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        child: CachedNetworkImage(
                          imageUrl: MyConfig.mockAvatar,
                          width: realWidth,
                          height: realWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        e,
                        style: const TextStyle(
                          color: Color(0xff7a7a7a),
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList()
                ..addAll(["group_info_add.png","group_info_delete.png"].map((e) {
                  return ClickEvent(
                    onTap: (){
                      print("當前點擊了$e");
                    },
                    child: Image.asset(
                      "assets/images/$e",
                      width: realWidth,
                      height: realWidth,
                    ),
                  );
                }).toList()),
            ),
          ),
          const SizedBox(height: 9,),
          ...items.map((e) {
            return GroupInfoItem(e);
          }).toList(),

          const SizedBox(height: 13,),
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16,),
            child: const Text(
              "退出群聊",
              style: TextStyle(color: Color(0xffFA5151),fontSize: 17,),
            ),
          ),
        ],
      ),
    );
  }
}


class GroupInfoItem extends StatelessWidget {
  final String label;
  const GroupInfoItem(this.label,{super.key});

  double topMargin(String label){
    if(label == "查找聊天內容"){
      return 7;
    }else if(label == "消息免打擾" || label == "群聊名稱"){
      return 9;
    }else if(label == "設置當前聊天背景" || label == "清空聊天訊息"|| label == "投訴"){
      return 13;
    }
    return 0;
  }

  bool notNeedBottomBorder(String label){
    bool value = label == "備註"
        || label == "查找聊天內容"
        || label == "保存到通訊錄"
        || label == "設置當前聊天背景"
        || label == "清空聊天訊息"
        || label == "投訴";
    return value;
  }

  bool notNeedRightArrow(String label){
    bool value = label == "消息免打擾"
        || label == "置頂聊天"
        || label == "保存到通訊錄"
        || label == "清空聊天訊息";

    return value;
  }

  Widget valueGet(String label){
    if(label == "群聊名稱" || label == "群二維碼" || label == "群公告"){
      return const Text(
        "未命名",
        style: TextStyle(
          color: Color(0xff7a7a7a),
          fontSize: 17,
        ),
      );
    }else if(label == "消息免打擾" || label == "置頂聊天" || label == "保存到通訊錄"){
      return CupertinoSwitch(
        value: false,
        onChanged: (value){},
      );

    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16,),
      margin: EdgeInsets.only(top: topMargin(label)),
      height: 56,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: notNeedBottomBorder(label)
                  ? Colors.transparent
                  : const Color(0xffe5e5e5),
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xff1a1a1a),
                fontSize: 17,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: valueGet(label),
              ),
            ),
            if(!notNeedRightArrow(label))
              Padding(
                padding: const EdgeInsets.only(left: 11,right: 19-15,),
                child: Image.asset(
                  "assets/images/group_info_right_arrow.png",
                  width: 7,
                  height: 13,
                ),
              ),
            const SizedBox(width: 15,),
          ],
        ),
      ),
    );
  }
}
