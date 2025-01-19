import 'package:flutter_wechat/pages/chat/chat_group/chat_group_binding.dart';
import 'package:flutter_wechat/pages/chat/chat_group/chat_group_view.dart';
import 'package:flutter_wechat/pages/chat/chat_single/chat_single_binding.dart';
import 'package:flutter_wechat/pages/chat/chat_single/chat_single_view.dart';
import 'package:flutter_wechat/pages/contact/add_friend/add_friend_binding.dart';
import 'package:flutter_wechat/pages/contact/add_msg/add_msg_binding.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_binding.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_view.dart';
import 'package:flutter_wechat/pages/contact/group_list/group_list_binding.dart';
import 'package:flutter_wechat/pages/contact/group_list/group_list_view.dart';
import 'package:flutter_wechat/pages/contact/launch_chat/launch_chat_binding.dart';
import 'package:flutter_wechat/pages/contact/launch_chat/launch_chat_view.dart';
import 'package:flutter_wechat/pages/msg/add_friend_info/add_friend_info_binding.dart';
import 'package:flutter_wechat/pages/msg/add_friend_info/add_friend_info_view.dart';
import 'package:flutter_wechat/pages/msg/msg_info/msg_info_binding.dart';
import 'package:flutter_wechat/pages/root/main/main_binding.dart';
import 'package:flutter_wechat/pages/root/main/main_view.dart';
import 'package:flutter_wechat/pages/root/root/root_binding.dart';
import 'package:flutter_wechat/pages/wechat/wechat_binding.dart';
import 'package:flutter_wechat/pages/chat/chat_group/chat_group_binding.dart';
import 'package:flutter_wechat/pages/chat/chat_group/chat_group_view.dart';
import 'package:flutter_wechat/pages/chat/chat_single/chat_single_binding.dart';
import 'package:flutter_wechat/pages/chat/chat_single/chat_single_view.dart';
import 'package:flutter_wechat/pages/contact/add_friend/add_friend_binding.dart';
import 'package:flutter_wechat/pages/contact/add_msg/add_msg_binding.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_binding.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_view.dart';
import 'package:flutter_wechat/pages/contact/group_list/group_list_binding.dart';
import 'package:flutter_wechat/pages/contact/group_list/group_list_view.dart';
import 'package:flutter_wechat/pages/contact/launch_chat/launch_chat_binding.dart';
import 'package:flutter_wechat/pages/contact/launch_chat/launch_chat_view.dart';
import 'package:flutter_wechat/pages/msg/add_friend_info/add_friend_info_binding.dart';
import 'package:flutter_wechat/pages/msg/add_friend_info/add_friend_info_view.dart';
import 'package:flutter_wechat/pages/msg/msg_info/msg_info_binding.dart';
import 'package:flutter_wechat/pages/root/main/main_binding.dart';
import 'package:flutter_wechat/pages/root/main/main_view.dart';
import 'package:flutter_wechat/pages/root/root/root_binding.dart';
import 'package:flutter_wechat/pages/wechat/wechat_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../pages/contact/add_friend/add_friend_view.dart';
import '../../pages/contact/add_msg/add_msg_view.dart';
import '../../pages/msg/msg_info/msg_info_view.dart';
import '../../pages/root/root/root_view.dart';
import 'app_routers.dart';

class AppPages{
  static List<GetPage> getPages = [
    GetPage(
      name: AppRouters.rootPage,
      page:() => RootPage(),
      binding: RootBinding(),
      bindings: [
        WechatBinding(),
        ContactBinding(),
      ],
    ),
    GetPage(
      name: AppRouters.mainPage,
      page:() => MainPage(),
      binding: MainBinding(),
      bindings: [
        WechatBinding(),
      ],
    ),
    GetPage(
      name: AppRouters.addFriendInfoPage,
      page:() => AddFriendInfoPage(),
      binding: AddFriendInfoBinding(),
    ),
    GetPage(
      name: AppRouters.msgInfoPage,
      page:() => MsgInfoPage(),
      binding: MsgInfoBinding(),
    ),
    GetPage(
      name: AppRouters.addFriendPage,
      page:() => const AddFriendPage(),
      binding: AddFriendBinding(),
    ),
    GetPage(
      name: AppRouters.addMsgPage,
      page:() => AddMsgPage(),
      binding: AddMsgBinding(),
    ),
    GetPage(
      name: AppRouters.contactPage,
      page:() => ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: AppRouters.chatGroupPage,
      page:() => ChatGroupPage(),
      binding: ChatGroupBinding(),
    ),
    GetPage(
      name: AppRouters.chatSinglePage,
      page:() => ChatSinglePage(),
      binding: ChatSingleBinding(),
    ),
    GetPage(
      name: AppRouters.launchChatPage,
      page:() => LaunchChatPage(),
      binding: LaunchChatBinding(),
    ),
    GetPage(
      name: AppRouters.groupListPage,
      page:() => GroupListPage(),
      binding: GroupListBinding(),
    ),
  ];
}