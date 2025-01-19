import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/func/save_file.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

import '../../util/func/func.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  List<String> items = ["掃一掃","換個樣式","保存圖片",];
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
              "assets/images/qr_code_arrow_left.png",
              width: 10,
            ),
          ),
        ),
        actions: [
          ClickEvent(
            onTap: (){
              print("點擊了more");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19,),
              child: Image.asset(
                "assets/images/qr_code_more.png",
                width: 18,
              ),
            ),
          ),
        ],
      ),

      body: RepaintBoundary(
        key: key,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          child: CachedNetworkImage(
                            imageUrl: MyConfig.mockAvatar,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 11,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MyConfig.mockNickName,
                              style: const TextStyle(
                                color: Color(0xff1a1a1a),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 3,),
                            Text(
                              MyConfig.mockNickName,
                              style: const TextStyle(
                                color: Color(0xffb3b3b3),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32,),
                    Image.asset(
                      "assets/images/qr_code_demo.png",
                      width: 246,
                      height: 246,
                    ),
                    const SizedBox(height: 32,),
                    const Text(
                      "掃一掃上面的二維碼圖案,加我為朋友.",
                      style: TextStyle(
                        color: Color(0xffb3b3b3),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 32,),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...items.map((e) {
                  final bool rightBorder = e!= items.last;
                  return ClickEvent(
                    onTap: (){
                      if(e== "掃一掃"){
                        print("掃一掃");
                        Func.scan();
                      }else if(e== "保存圖片"){
                        SaveFile.saveScreenImage(key);
                      }else{
                        print(e);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          e,
                          style: const TextStyle(
                            color: Color(0xff576B95),
                            fontSize: 16,
                          ),
                        ),
                        if(rightBorder)
                          const SizedBox(width: 16,),
                        if(rightBorder)
                          Container(
                            height: 13,
                            width: 1,
                            color: const Color(0xffb3b3b3),
                          ),
                        if(rightBorder)
                          const SizedBox(width: 16,),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom+29,),
          ],
        ),
      ),
    );
  }
}
