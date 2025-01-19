import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({super.key});

  @override
  State<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        backgroundColor: const Color(0xffededed),
        elevation: 0,
        title: const Text(
          "設置名字",
          style: TextStyle(
            color: Color(0xff181818),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: (17*2+23),
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: const Center(
            child: Text(
              "取消",
              style: TextStyle(
                color: Color(0xff181818),
                fontSize: 16,
              ),
            ),
          ),
        ),
        actions: [
          ClickEvent(
            onTap: (){
              if(controller.text==""){
                return;
              }
              print("點了完成");
            },
            child: UnconstrainedBox(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 12,),
                decoration: BoxDecoration(
                  color: controller.text==""? const Color(0xffd8d8d8):const Color(0xff07c160),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Text(
                  "完成",
                  style: TextStyle(
                    color: controller.text==""? const Color(0xffb4b4b4) : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

      body: ListView(
        children: [
          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                const SizedBox(width: 13,),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    cursorColor: const Color(0xffc5f0da),
                    onChanged: (_){
                      setState(() {});
                    },
                  ),
                ),
                ClickEvent(
                  onTap: (){
                    print("點擊了刪除");
                    controller.clear();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Image.asset(
                      "assets/images/set_name_delete.png",
                      width: 17,
                      height: 17,
                    ),
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
