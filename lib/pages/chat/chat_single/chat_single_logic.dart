import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:get/get.dart';

class ChatSingleLogic extends GetxController with MoreInterface, ChatLogic{
  @override
  List<List<String>> moreItems = [
    ["chat_more_001.png","照片","27","22",],
    ["chat_more_002.png","拍攝","27","22",],
    ["chat_more_003.png","視頻通話","29","18",],
  ];
}
