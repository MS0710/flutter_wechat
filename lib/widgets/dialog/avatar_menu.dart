import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/save_file.dart';
import 'package:flutter_wechat/util/config/my_config.dart';
import 'package:flutter_wechat/util/func/save_file.dart';
import 'package:get/get.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

void avatarMenu(BuildContext context){
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context){
      return const AvatarMenu();
    },
  );
}

class AvatarMenu extends StatefulWidget {
  const AvatarMenu({super.key});

  @override
  State<AvatarMenu> createState() => _AvatarMenuState();
}

class _AvatarMenuState extends State<AvatarMenu> {
  List<String> items = ["拍照","從手機相冊選擇","保存圖片","取消",];
  static double itemHeight = 55;

  void pictureRecord() async{
    print("11");
    AssetEntity? assetEntity = await CameraPicker.pickFromCamera(context);
    print("22");
    print("assetEntity是否為空::assetEntity::${assetEntity==null}");
    if(assetEntity==null){
      return;
    }
    print("文件路徑：${(await assetEntity.file)?.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(13),),

        ),
        height: (items.length * itemHeight)+MediaQuery.of(context).padding.bottom,
        width: double.infinity,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          children: items.map((e) {
            return InkWell(
              onTap: (){
                Get.back();
                print("點擊了${e}");
                if(e == "拍照"){
                  pictureRecord();
                }else if(e == "保存圖片"){
                  SaveFile.saveRemoteImage(MyConfig.mockAvatar);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                height: itemHeight,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: e=="保存圖片" || e=="取消"
                          ? Colors.transparent
                          : const Color(0xffe5e5e5),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    color: Color(0xff1b1b1b),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
