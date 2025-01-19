import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/chat/chat_logic.dart';
import 'package:flutter_wechat/util/func/check.dart';
import 'package:flutter_wechat/wechat_flutter.dart';
import 'package:flutter_wechat/widgets/close_bar.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info.dart';

import 'group_list_logic.dart';

class GroupListPage extends StatelessWidget {
  GroupListPage({Key? key}) : super(key: key);

  final GroupListLogic logic = Get.put(GroupListLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseBar(),
      body: GetBuilder<GroupListLogic>(
        builder: (context){
          return ListView.builder(
            itemBuilder: (context,index){
              return GroupItem(currentIndex: index,items: logic.items,);
            },
            itemCount: logic.items.length,
          );
        },
      ),
    );
  }
}


class GroupItem extends StatelessWidget {
  final int currentIndex;
  final List<V2TimGroupInfo> items;

  const GroupItem({
    super.key,
    required this.currentIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final V2TimGroupInfo currentItem = items[currentIndex];
    bool notNeedBottomLine = currentIndex == items.length-1;
    final String groupNameStr = strNotEmpty( currentItem.groupName)
        ?  currentItem.groupName!
        :  currentItem.groupID;

    return InkWell(
      onTap: (){
        print("開始跳轉群聊::currentItem.groupID::[${currentItem.groupID}],currentItem.groupName::[${currentItem.groupName}]");
        ChatPageModel chatPageModel = ChatPageModel(
          toId: currentItem.groupID,
          isGroup: true,
          name: groupNameStr,
        );
        Get.toNamed(AppRouters.chatGroupPage,arguments: chatPageModel);
      },
      child: Row(
        children: [
          const SizedBox(width: 16,),
          Container(
            margin: const EdgeInsets.only(top: 9,bottom: 4,),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                imageUrl: MyConfig.mockAvatar,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 13,),
          Expanded(
            child: Container(
              height: 53,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: notNeedBottomLine ? Colors.transparent : const Color(0xffe5e5e5),
                  ),
                ),
              ),
              child: Text(
                groupNameStr,
                style: const TextStyle(
                  color: Color(0xff181818),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
