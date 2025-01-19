import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/util/func/click_event.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

class MsgVideo extends StatelessWidget {
  final V2TimMessage timMsg;
  const MsgVideo({super.key,required this.timMsg,});

  @override
  Widget build(BuildContext context) {
    bool self = timMsg.isSelf ?? false;
    print("MsgVideo::timMsg.faceUrl = ${timMsg.faceUrl}");
    print("MsgVideo::timMsg.videoElem?.snapshotPath = ${timMsg.videoElem?.snapshotPath}");
    print("MsgVideo::timMsg.videoElem?.localVideoUrl = ${timMsg.videoElem!.snapshotUrl}");
    print("MsgVideo::timMsg.videoElem?.videoPath = ${timMsg.videoElem?.videoPath}");
    print("MsgVideo::timMsg.videoElem?.videoUrl = ${timMsg.videoElem!.videoUrl}");
    print("MsgVideo::timMsg.videoElem?.localVideoUrl = ${timMsg.videoElem!.localVideoUrl}");

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
                timMsg.nickName ?? "匿名",
                style: const TextStyle(
                  color: Color(0xff828282),
                  fontSize: 13,
                ),
              ),

                (){
              print("MsgVideo::strNotEmpty(timMsg.videoElem?.snapshotPath)::${strNotEmpty(timMsg.videoElem?.snapshotPath)}");
              String useUrlSnapshot = strNotEmpty(timMsg.videoElem?.snapshotPath) && File(timMsg.videoElem!.snapshotPath!).existsSync()
                ? timMsg.videoElem!.snapshotPath!
                : timMsg.videoElem!.snapshotUrl??"";
              String useUrlVideo = strNotEmpty(timMsg.videoElem?.videoPath) && File(timMsg.videoElem!.videoPath!).existsSync()
                  ? timMsg.videoElem!.videoPath!
                  : timMsg.videoElem!.videoUrl??"";
              double width = 100;
              double height = 100 *
                  timMsg.videoElem!.snapshotHeight!.toDouble() /
                  timMsg.videoElem!.snapshotWidth!.toDouble();
              print("MsgVideo::useUrlSnapshot::${useUrlSnapshot}");
              print("MsgVideo::useUrlVideo::${useUrlVideo}");

              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: ClickEvent(
                  onTap: (){
                    print("去視頻播放,useUrlVideo::$useUrlVideo");
                    Get.to(VideoPlayPage(useUrlVideo));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      isNetUrl(useUrlSnapshot)
                          ? CachedNetworkImage(
                        imageUrl: useUrlSnapshot,
                        width: width,
                        height: height,
                      ) : (){
                        try{
                          return Image.file(
                            File(useUrlSnapshot),
                            width: width,
                            height: height,
                          );
                        }catch(e){
                          print("加載封面出錯::${e.toString()}");
                          return Container();
                        }
                      }(),
                      const Icon(
                        CupertinoIcons.play_circle,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
              //return Container();
            }(),
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


class VideoPlayPage extends StatefulWidget {
  final String useUrlVideo;
  const VideoPlayPage(this.useUrlVideo,{super.key,});

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  FijkPlayer fijkPlayer = FijkPlayer();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fijkPlayer.setDataSource(widget.useUrlVideo,autoPlay: true);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: Center(
            child: Image.asset(
              "assets/images/chat_info_arrow_left.png",
              width: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: FijkView(
        player: fijkPlayer,
        color: Colors.black,
      ),
    );
  }
}
