import 'package:azlistview/azlistview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/model/contact_model.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

import 'contact_logic.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final ContactLogic logic = Get.put(ContactLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffededed),
        title: const Text(
          "微信",
          style: TextStyle(
            color: Color(0xff181818),
            fontSize: 16,
          ),
        ),
        actions: [
          ClickEvent(
            onTap: (){
              print("點擊了添加好友");
              Get.toNamed(AppRouters.addFriendPage);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17,),
              child: Image.asset(
                "assets/images/contact_right_top_add.png",
                width: 23,
                height: 21,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 15),
            color: const Color(0xffededed),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 7,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/msg_search.png",
                    width: 17,
                  ),
                  const SizedBox(width: 7,),
                  const Text(
                    "搜索",
                    style: TextStyle(
                      color: Color(0xffb3b3b3),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<ContactLogic>(
              builder: (logic){
                return AzListView(
                  indexBarData: logic.indexBarData,
                  data: logic.items,
                  itemCount: logic.items.length,
                  indexBarOptions: IndexBarOptions(
                    localImages: [
                      searchIcon,
                    ],
                  ),
                  itemBuilder: (BuildContext context,int currentIndex){
                    if(currentIndex == 0){
                      return Column(
                        children: [
                          ...logic.defItems.map((e) {
                            return ContactItemDef(
                              e: e,
                              needBorder: e!= logic.defItems.last,
                            );
                          }).toList(),
                        ],
                      );
                    }

                    final e = logic.items[currentIndex];
                    final itemWidget = ContactItem(e: e, currentIndex: currentIndex, items: logic.items);
                    return itemWidget;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactItemDef extends StatelessWidget {
  final bool needBorder;
  final List<String> e;
  const ContactItemDef({
    super.key,
    this.needBorder = false,
    required this.e,
  });

  @override
  Widget build(BuildContext context) {
    return ClickEvent(
      onTap: (){
        if(e[1]=="群聊列表"){
          Get.toNamed(AppRouters.groupListPage);
        }else{
          print("敬請期待");
        }
      },
      child: Row(
        children: [
          const SizedBox(width: 16,),
          Container(
            margin: const EdgeInsets.only(top: 9,bottom: 4,),
            child: Stack(
              alignment: Alignment.center ,
              children: [
                Image.asset(
                  "assets/images/contact_item_back.png",
                  width: 40,
                  height: 40,
                ),

                Image.asset(
                  "assets/images/${e[0]}",
                  width: double.parse(e[2]),
                  height: double.parse(e[3]),
                ),
              ],
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
                    color: needBorder
                        ? const Color(0xffe5e5e5)
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Text(
                e[1],
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


class ContactItem extends StatelessWidget {
  final ContactModel e;
  final int currentIndex;
  final List<ContactModel> items;

  const ContactItem({
    super.key,
    required this.e,
    required this.currentIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final int nextIndex = currentIndex+1;
    bool notNeedBottomLine = currentIndex == items.length-1 || items[nextIndex].isShowSuspension;

    return ClickEvent(
      onTap: (){
        Get.toNamed(AppRouters.msgInfoPage,arguments: e.info);
      },
      child: Column(
        children: [
          if(e.isShowSuspension)
            Container(
              color: const Color(0xffededed),
              padding: const EdgeInsets.only(left: 16,),
              height: 32,
              alignment: Alignment.centerLeft,
              child: Text(
                e.getSuspensionTag(),
                style: const TextStyle(color: Color(0xff6b6b6b),fontSize: 14,),
              ),
            ),
          Row(
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
                    e.name,
                    style: const TextStyle(
                      color: Color(0xff181818),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ],
          ),
          if(e.isShowSuspension)
            const SizedBox(height: 8,),
        ],
      ),
    );
  }
}

