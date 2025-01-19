import 'package:azlistview/azlistview.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_logic.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_logic.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';

class ContactModel extends ISuspensionBean{
  String get name{
    return info?.userProfile?.nickName ?? info?.userID ?? " ";
  }
  final String tag;
  final V2TimFriendInfo? info;

  ContactModel({this.info,this.tag = "#"});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    if(tag == searchIcon){
      return tag;
    }
    final result = PinyinHelper.getPinyinE(name)[0].toString().toUpperCase();
    if(!RegExp("[A-Z]").hasMatch(result)){
      return "#";
    }else{
      return result;
    }

  }

}