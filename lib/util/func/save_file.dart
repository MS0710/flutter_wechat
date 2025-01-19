import 'dart:typed_data';
import 'dart:ui' as ui show ImageByteFormat, Image;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveFile{
  static Future saveScreenImage(GlobalKey key) async{
    RenderRepaintBoundary repaintBoundary =
    key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await repaintBoundary.toImage(pixelRatio: 3.0);
    ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
    Uint8List uint8list = byteData.buffer.asUint8List();
    final result = ImageGallerySaver.saveImage(uint8list,isReturnImagePathOfIOS: true);
    print("保存圖片結果::$result");
  }

  static Future saveRemoteImage(String imageUrl) async{
    Response rsp = await Dio()
        .get(imageUrl,options: Options(responseType: ResponseType.bytes),);
    print("響應數據::${rsp.data}");
    Uint8List uint8list = rsp.data;
    final result = ImageGallerySaver.saveImage(uint8list,isReturnImagePathOfIOS: true);
    print("保存圖片結果::$result");
  }
}