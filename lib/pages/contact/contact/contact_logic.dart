import 'package:azlistview/azlistview.dart';
import 'package:flutter_wechat/util/im/im_user.dart';
import 'package:flutter_wechat/util/model/contact_model.dart';
import 'package:get/get.dart';

String get searchIcon{
  return "assets/images/add_friend_search.png";
}

mixin ContactContentLogic on GetxController{
  List<String> indexBarData = [];
  List<ContactModel> items = [];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData().then((value) {
      handleData();
    });
  }

  void handleData(){
    for(int i=0; i< items.length;i++){
      final String tag = items[i].getSuspensionTag();
      if(!indexBarData.contains(tag) && tag != "#"){
        indexBarData.add(tag);
      }
    }

    indexBarData.sort();
    indexBarData.add("#");
    indexBarData.insert(0, searchIcon);
    SuspensionUtil.sortListBySuspensionTag(items);
    SuspensionUtil.setShowSuspensionStatus(items);
    items.insert(0, ContactModel(tag: searchIcon));
    update();
  }

  Future getData() async{
    items = (await ImUser.getContact()).map((e) {
      return ContactModel(
        info: e,
      );
    }).toList();
  }

}

class ContactLogic extends GetxController with ContactContentLogic{

  List<List<String>> defItems = [
    ["contact_add.png","新的朋友","23","21"],
    ["contact_chat.png","僅聊天的朋友","27","24"],
    ["contact_chat.png","群聊列表","27","24"],
  ];
}
