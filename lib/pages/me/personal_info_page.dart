import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/me/big_avatar_page.dart';
import 'package:flutter_wechat/pages/me/change_name_page.dart';
import 'package:flutter_wechat/pages/me/qr_code_page.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  List<String> items = [
    "頭像",
    "名字",
    "拍一拍",
    "微信號",
    "我的二維碼",
    "更多",
    "來電鈴聲",
    "微信豆",
    "我的地址",
  ];

  bool needTopMargin(String value){
    List<String> need = ["來電鈴聲", "微信豆", "我的地址",];
    return need.contains(value);
  }

  bool needLine(String value){
    List<String> need = ["頭像", "名字", "拍一拍", "微信號", "我的二維碼",];
    return need.contains(value);
  }

  void actions(String value){
    switch(value){
      case "我的二維碼":
        print("點擊了我的二維碼");
        Get.to(const QrCodePage());
        break;
      case "名字":
        print("點擊了名字");
        Get.to(const ChangeNamePage());
        break;
      case "頭像":
        print("點擊了頭像");
        Get.to(const BigAvatarPage());
        break;
      default:
        print("點擊了其他");
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = const TextStyle(
      color: Color(0xff737373),
      fontSize: 16,
    );
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        backgroundColor: const Color(0xffededed),
        elevation: 0,
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: Center(
            child: Image.asset(
              "assets/images/info_left_arrow.png",
              width: 10,
              height: 18,
            ),
          ),
        ),
        title: const Text(
          "個人信息",
          style: TextStyle(
            color: Color(0xff181818),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context,index){
          final value = items[index];
          return ClickEvent(
            onTap: (){
              actions(value);
            },
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: needTopMargin(value)? 8:0),
              child: Container(
                margin: const EdgeInsets.only(left: 16,),
                padding: const EdgeInsets.symmetric(vertical: 16,),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: needLine(value)
                          ? const Color(0xffe5e5e5)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xff181818),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: (){
                          if(value == "頭像"){
                            return ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(7)),
                              child: CachedNetworkImage(
                                imageUrl: MyConfig.mockAvatar,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                              ),
                            );
                          }else if(value == "名字"){
                            return Text(
                              MyConfig.mockNickName,
                              style: hintStyle,
                            );
                          }else if(value == "微信號"){
                            return Text(
                              MyConfig.mockWechatId,
                              style: hintStyle,
                            );
                          }else if(value == "我的二維碼"){
                            return Image.asset(
                              "assets/images/info_qr_code.png",
                              width: 18,
                              height: 19,
                            );
                          }else{
                            return Container();
                          }
                        }(),
                      ),
                    ),

                    const SizedBox(width: 11,),
                    Image.asset(
                      "assets/images/info_arrow.png",
                      width: 7,
                      height: 13,
                    ),
                    const SizedBox(width: 19,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
