import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wechat/util/im/im_sdk.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/close_bar.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }

}

class _LoginPage extends State<LoginPage>{
  static String defContent = MyConfig.mockPhone;
  //TextEditingController controller = TextEditingController(text: defContent);
  TextEditingController controller = TextEditingController();
  RxString content = defContent.obs;

  void login(){
    if(controller.text == ""){
      showToast("請輸入手機號");
      return;
    }

    //RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    RegExp exp = RegExp(r'^\d{10}$');
    if(!exp.hasMatch(controller.text)){
      showToast("輸入手機號有誤");
      return;
    }
    ImSdk.login(controller.text);
    showToast("校驗通過");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("頁面構建");
    TextStyle labelStyle = const TextStyle(color: Color(0xff1A1A1A),fontSize: 16,);


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CloseBar(),

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          print("點擊空白區域");
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                children: [
                  const SizedBox(height: 51,),
                  const Center(
                    child: Text(
                      "手機號登入",
                      style: TextStyle(
                        color: Color(0xff1A1A1A),
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 47,),
                  Container(color: const Color(0xffd8d8d8), height: 1,),
                  const SizedBox(height: 17,),
                  Row(
                    children: [
                      SizedBox(
                        width: 107,
                        child: Text("國家/地區",style: labelStyle,),
                      ),
                      Expanded(
                          child: Text("中國台灣",style: labelStyle,)
                      ),
                    ],
                  ),

                  const SizedBox(height: 17,),
                  Container(color: const Color(0xffd8d8d8), height: 1,),
                  Container(
                    height: 57,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 107,
                          child: Text("手機號",style: labelStyle,),
                        ),
                        const Text(
                          "+886",
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            onChanged: (v){
                              content.value = v;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            ],
                            cursorColor: const Color(0xff07c160),
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: "請填寫手機號碼",
                              hintStyle: TextStyle(
                                color: Color(0xffb3b3b3),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        Obx((){
                          if(content.value != ""){
                            return IconButton(
                              onPressed: (){
                                controller.clear();
                                content.value = "";
                              },
                              icon: Image.asset(
                                "assets/images/login_input_delete.png",
                                width: 17,
                                height: 17,
                              ),
                            );
                          }else{
                            return Container();
                          }
                        }),
                      ],
                    ),
                  ),
                  Container(color: const Color(0xffd8d8d8), height: 1,),
                ],
              ),
            ),

            const Text(
              "上述手機號僅用於登入驗證",
              style: TextStyle(
                color: Color(0xffb3b3b3),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 22,),
            ClickEvent(
              onTap: (){
                login();
              },
              child: Container(
                width: 184,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xff07c160),
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "同意並繼續",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 101,),
            SizedBox(height: MediaQuery.of(context).padding.bottom,),
          ],
        ),
      ),
    );
  }

}
