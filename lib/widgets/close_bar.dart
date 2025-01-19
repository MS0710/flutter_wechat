import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CloseBar extends AppBar{
  CloseBar({super.key}):super(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: InkWell(
      onTap: (){
        Get.back();
      },
      child: UnconstrainedBox(
        child: Image.asset(
          "assets/images/login_close.png",
          width: 15,
          height: 15,
        ),
      ),
    ),
  );
}