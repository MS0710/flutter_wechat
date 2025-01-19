import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:get/get.dart';

class ChatGroupLogic extends GetxController with MoreInterface, ChatLogic{
  @override
  List<List<String>> moreItems = [
    ["chat_more_001.png","照片","27","22",],
    ["chat_more_002.png","拍攝","27","22",],
    ["chat_more_003.png","視頻通話","29","18",],
    ["chat_more_004.png","位置","27","28",],
    ["chat_more_005.png","紅包","20","25",],
    ["chat_more_006.png","轉帳","24","19",],
    ["chat_more_007.png","語音輸入","18","23",],
    ["chat_more_008.png","收藏","24","27",],
    ["chat_more_009.png","個人名片","26","24",],
    ["chat_more_0010.png","文件","27","22",],
    ["chat_more_0011.png","音樂","28","28",],
  ];
}
