import 'package:azlistview/azlistview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/pages/contact/contact/contact_logic.dart';
import 'package:flutter_wechat/util/model/contact_model.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

import 'launch_chat_logic.dart';

class LaunchChatPage extends StatelessWidget {
  LaunchChatPage({Key? key}) : super(key: key);

  final LaunchChatLogic logic = Get.put(LaunchChatLogic());

  @override
  Widget build(BuildContext context) {
    print("構建頁面");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffededed),
        elevation: 0,
        leading: ClickEvent(
          onTap: (){
            Get.back();
          },
          child: Center(
            child: Image.asset(
              "assets/images/select_contact_close.png",
              height: 15,
            ),
          ),
        ),
        title: const Text(
          "選擇聯繫人",
          style: TextStyle(color: Color(0xff181818),fontSize: 16),
        ),
      ),

      body: GetBuilder<LaunchChatLogic>(
        builder: (logic){
          return Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 55,
                      decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xffe5e5e5),width: 1,),
                          )
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 19,),
                          Image.asset(
                            "assets/images/select_contact_search.png",
                            width: 17,
                            height: 17,
                          ),
                          const SizedBox(width: 19,),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "搜索",
                                helperStyle: TextStyle(
                                  color: Color(0xffb3b3b3),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 20,),
                    const Padding(
                      padding: EdgeInsets.only(left: 16,),
                      child: Text(
                        "選擇一個或多個聯繫人發起聊天",
                        style: TextStyle(
                          color: Color(0xff181818),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 21,),

                  ],
                ),
              ),

              Expanded(
                child: AzListView(
                  indexBarData: logic.indexBarData,
                  data: logic.items,
                  itemCount: logic.items.length,
                  indexBarOptions: IndexBarOptions(
                    localImages: [searchIcon,],
                  ),
                  itemBuilder: (BuildContext context,int currentIndex){
                    if(currentIndex == 0){
                      return Container();
                    }

                    final e = logic.items[currentIndex];
                    final itemWidget = SelectContactItem(
                      model: e,
                      currentIndex: currentIndex,
                      items: logic.items,
                      selectHandle: (model){
                        logic.selectItems.add(model);
                        //setState(() {});
                      },
                      cancelHandle: (model){
                        logic.selectItems.remove(model);
                      },
                    );
                    return itemWidget;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                decoration: const BoxDecoration(
                  color: Color(0xfff9f9f9),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xffe5e5e5),
                      width: 1,
                    ),
                  ),
                ),
                child: ButtonBar(
                  buttonPadding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                  children: [
                    Obx(() {
                      return ClickEvent(
                        onTap: (){
                          logic.handle();
                        },
                        child: Container(
                          width: 82,
                          height: 32,
                          decoration: BoxDecoration(
                            color: logic.selectItems.length > 0
                                ? const Color(0xff07c160)
                                : Colors.grey,
                            borderRadius: const BorderRadius.all(Radius.circular(5),),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "完成${logic.selectItems.length>0 ? "(${logic.selectItems.length})" : ""}",
                            style: const TextStyle(
                              color: Color(0xfffffcfc),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

typedef ItemCancelHandle(ContactModel model);
typedef ItemSelectHandle(ContactModel model);

class SelectContactItem extends StatefulWidget {
  final ContactModel model;
  final int currentIndex;
  final List<ContactModel> items;
  final ItemCancelHandle cancelHandle;
  final ItemSelectHandle selectHandle;

  const SelectContactItem({
    super.key,
    required this.model,
    required this.currentIndex,
    required this.items,
    required this.cancelHandle,
    required this.selectHandle,
  });

  @override
  State<SelectContactItem> createState() => _SelectContactItemState();
}

class _SelectContactItemState extends State<SelectContactItem> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    final int nextIndex = widget.currentIndex+1;
    bool notNeedBottomLine = widget.currentIndex == widget.items.length-1 || widget.items[nextIndex].isShowSuspension;

    return InkWell(
      onTap: (){
        select = !select;
        setState(() {});
        if(select){
          widget.selectHandle(widget.model);
        }else{
          widget.cancelHandle(widget.model);
        }
      },
      child: Column(
        children: [
          if(widget.model.isShowSuspension)
            Container(
              color: const Color(0xffededed),
              padding: const EdgeInsets.only(left: 16,),
              height: 32,
              alignment: Alignment.centerLeft,
              child: Text(
                widget.model.getSuspensionTag(),
                style: const TextStyle(color: Color(0xff6b6b6b),fontSize: 14,),
              ),
            ),
          Row(
            children: [
              const SizedBox(width: 16,),
              Image.asset("assets/images/select_contact_${select ? "": "un"}select.png",
                width: 24,
                height: 24,
              ),
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
                    widget.model.name,
                    style: const TextStyle(
                      color: Color(0xff181818),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ],
          ),
          if(widget.model.isShowSuspension)
            const SizedBox(height: 8,),
        ],
      ),
    );
  }
}
