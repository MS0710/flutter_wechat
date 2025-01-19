import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

class MsgText extends StatelessWidget {
  final V2TimMessage timMsg;
  const MsgText({super.key,required this.timMsg,});

  @override
  Widget build(BuildContext context) {
    bool self = timMsg.isSelf ?? false;
    final double trianglesSize = 6;
    final List<Widget> bodyList = [
      const SizedBox(width: 12,),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: CachedNetworkImage(
          imageUrl: strNotEmpty(timMsg.faceUrl) ? timMsg.faceUrl! : MyConfig.mockAvatar,
          width: 41,
          height: 41,
          fit: BoxFit.cover,
        ),
      ),

      const SizedBox(width: 5,),
      Expanded(
        child: Column(
          crossAxisAlignment: self? CrossAxisAlignment.end: CrossAxisAlignment.start,
          children: [
            if(!self && (timMsg.groupID!=null))
              Text(
                timMsg.nickName ?? "",
                style: const TextStyle(
                  color: Color(0xff828282),
                  fontSize: 13,
                ),
              ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: trianglesSize,),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width*0.7,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
                  decoration: BoxDecoration(
                    color: self ? const Color(0xff95ec69):Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    timMsg.textElem?.text ?? "",
                    style: const TextStyle(
                      color: Color(0xff181818),
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  left: !self ? 0:null,
                  right: self ? 0:null,
                  top: (){
                    TextPainter textPainter =  TextPainter(
                      text: const TextSpan(
                        text: "你",
                      ),
                      textDirection: TextDirection.ltr,
                    )..layout(
                      maxWidth: 200,
                    );
                    double result = (textPainter.size.height+20-(trianglesSize*2))/2;
                    return result;
                  }(),
                  child: Container(
                    width: trianglesSize,
                    height: trianglesSize*2,
                    child: CustomPaint(
                      painter: MsgTraingle(self),

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17/2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: self ? bodyList.reversed.toList() : bodyList,
      ),
    );
  }
}

class MsgTraingle extends CustomPainter{
  final bool self;

  MsgTraingle(this.self);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    paint.color = self ? const Color(0xff95ec69) : Colors.white;
    paint.style = PaintingStyle.fill;
    Path path = Path();
    if(self){
      path.moveTo(size.width, size.height/2);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    }else{
      path.moveTo(0, size.height/2);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}
