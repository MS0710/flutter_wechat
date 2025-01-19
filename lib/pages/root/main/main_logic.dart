import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/login_page.dart';
import '../../login/register_page.dart';

class MainLogic extends GetxController {
  void action(BuildContext context,String value){
    Get.to(value == "0" ? const LoginPage():const RegisterPage());
  }

}
