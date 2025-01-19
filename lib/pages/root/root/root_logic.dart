import 'package:flutter/cupertino.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_view.dart';
import 'package:get/get.dart';

import '../../find/find_page.dart';
import '../../me/me_page.dart';
import '../../wechat/wechat_page.dart';

class BottomModel{
  final double width;
  final double height;
  final String iconName;
  final String label;

  BottomModel(this.width, this.height, this.iconName, this.label);
}

class RootLogic extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  List<BottomModel> items = [
    BottomModel(24, 21, "msg", "微信"),
    BottomModel(26, 21, "contact", "通訊錄"),
    BottomModel(24, 24, "find", "發現"),
    BottomModel(23, 21, "me", "我"),
  ];

  List<Widget> pages = [
    WechatPage(),
    ContactPage(),
    const FindPage(),
    const MePage(),
  ];

}
