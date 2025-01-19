import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:get/get.dart';
import '../../util/func/func.dart';

void moreDialog(BuildContext context){
  OverlayEntry? entry = null;
  RenderBox renderBox = context.findRenderObject()! as RenderBox;
  Offset offset = renderBox.localToGlobal(Offset.zero);
  print("點擊了更多 offset dx = ${offset.dx} ; offset dy = ${offset.dy}");

  entry = OverlayEntry(builder: (context){
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: (){
          entry!.remove();
        },
        child: MoreDialog(
          dy: offset.dy,
          dismissHandle: (){
            entry!.remove();
          },
        ),
      ),
    );
  });

  Overlay.of(context).insert(entry);
}

class MoreDialog extends StatefulWidget {
  final VoidCallback dismissHandle;
  final double dy;
  const MoreDialog({super.key, required this.dismissHandle, required this.dy});

  @override
  State<MoreDialog> createState() => _MoreDialogState();
}

class _MoreDialogState extends State<MoreDialog> {
  List<List<String>> items = [
    ["msg_more_lauch_group.png","發起聊天"],
    ["msg_more_add_friend.png","添加朋友"],
    ["msg_more_scan.png","掃一掃"],
  ];

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 53;

    return InkWell(
      onTap: (){
        widget.dismissHandle();
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: widget.dy+kToolbarHeight-30,),
            Container(
              height: 7,
              width: 25,
              margin: const EdgeInsets.only(right: 17),
              child: CustomPaint(
                painter: MoreTopPainter(),
              ),
            ),
            Container(
              width: 134,
              height: (itemHeight * items.length),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Color(0xff4c4c4c),
              ),
              margin: const EdgeInsets.only(right: 7,),
              child: Column(
                children: items.map((e) {
                  return InkWell(
                    onTap: (){
                      print("點了${e}");
                      widget.dismissHandle();
                      if(e[1]=="發起聊天"){
                        Get.toNamed(AppRouters.launchChatPage);
                      }else if(e[1]=="添加朋友"){
                        Get.toNamed(AppRouters.addFriendPage);
                      }else if(e[1]=="掃一掃"){
                        Func.scan();
                      }
                    },
                    child: SizedBox(
                      height: itemHeight,
                      child: Row(
                        children: [
                          const SizedBox(width: 14,),
                          Image.asset(
                            "assets/images/${e[0]}",
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              height: itemHeight-1,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: e[1] != items.last[1] ? const Color(0xff535353): Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                e[1],
                                style: const TextStyle(color: Color(0xffcfcfcf),fontSize: 17,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreTopPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = const Color(0xff4c4c4c)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo((size.width/2)-3, 0);
    path.lineTo((size.width/2)+3, 0);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}
