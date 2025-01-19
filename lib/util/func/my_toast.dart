import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text){
  print("Fluttertoast.showToast::msg:{$text}");
  Fluttertoast.showToast(msg: text,gravity: ToastGravity.CENTER);
}