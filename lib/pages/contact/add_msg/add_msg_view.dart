import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'add_msg_logic.dart';

class AddMsgPage extends StatelessWidget {
  AddMsgPage({Key? key}) : super(key: key);

  final AddMsgLogic logic = Get.put(AddMsgLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "申請添加朋友",
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
              "assets/images/chat_info_arrow_left.png",
              width: 10,
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32,),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18,top: 29-17,),
                child: Text(
                  "發送添加朋友申請",
                  style: logic.titleStyle,
                ),
              ),
              const SizedBox(height: 7,),
              Container(
                height: 96,
                decoration: const BoxDecoration(
                  color: Color(0xfff7f7f7),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  controller: TextEditingController(text: "我是往事如風",),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 16,),
                  ),
                  style: logic.fieldStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,top: 20,bottom: 7),
                child: Text(
                  "設置備註",
                  style: logic.titleStyle,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xfff7f7f7),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Obx((){
                  return TextField(
                    focusNode: logic.focusNode,
                    controller: logic.markName,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 16,),
                    ),
                    style: logic.markLight.value ? logic.fieldStyle : logic.fieldHideStyle,
                  );
                }),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18,top: 19,bottom: 7),
                child: Text(
                  "添加標籤與描述",
                  style: logic.titleStyle,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xfff7f7f7),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ["標籤","描述"].map((e) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: e=="描述"?Colors.transparent : const Color(0xffdedede),
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(17),
                      child: Text(e,style: logic.fieldStyle,),
                    );
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18,top: 19,bottom: 7),
                child: Text(
                  "設置朋友權限",
                  style: logic.titleStyle,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xfff7f7f7),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ["聊天,朋友圈,微信運動等","僅聊天"].map((e) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: e=="僅聊天"?Colors.transparent : const Color(0xffdedede),
                            width: 1,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(17),
                      child: Text(e,style: logic.fieldStyle,),
                    );
                  }).toList(),
                ),
              ),
              Container(height: 124,),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 124+MediaQuery.of(context).padding.bottom,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(1),
                  ],
                ),
              ),
              child: ClickEvent(
                onTap: (){
                  logic.reqAddFriend();
                },
                child: Container(
                  height: 49,
                  width: 185,
                  margin: EdgeInsets.only(
                    bottom: 24+MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xff07c160),
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "發送",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
