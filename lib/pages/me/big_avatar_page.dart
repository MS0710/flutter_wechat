import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/dialog/avatar_menu.dart';
import 'package:photo_view/photo_view.dart';

class BigAvatarPage extends StatefulWidget {
  const BigAvatarPage({super.key});

  @override
  State<BigAvatarPage> createState() => _BigAvatarPageState();
}

class _BigAvatarPageState extends State<BigAvatarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: Center(
            child: Image.asset(
              "assets/images/qr_code_arrow_left.png",
              width: 10,
              color: Color(0xff333333),
            ),
          ),
        ),
        actions: [
          ClickEvent(
            onTap: (){
              print("點擊了more2");
              avatarMenu(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19,),
              child: Image.asset(
                "assets/images/qr_code_more.png",
                width: 18,
                //color: Color(0xff333333),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: PhotoView(
        minScale: 0.2,
        maxScale: 5.0,
        imageProvider: CachedNetworkImageProvider(MyConfig.mockAvatar,),
      ),
    );
  }
}


class BigImagePage extends StatefulWidget {
  final String url;
  const BigImagePage(this.url,{super.key});

  @override
  State<BigImagePage> createState() => _BigImagePageState();
}

class _BigImagePageState extends State<BigImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: PhotoView(
        minScale: 0.2,
        maxScale: 5.0,
        imageProvider: CachedNetworkImageProvider(
          widget.url,
        ),
        onTapUp: (_,__,___){
          Get.back();
        },
      ),
    );
  }
}
