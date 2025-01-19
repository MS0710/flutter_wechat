import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'root_logic.dart';

class RootPage extends StatelessWidget {
  RootPage({Key? key}) : super(key: key);

  final RootLogic logic = Get.put(RootLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: Obx((){
        return Stack(
          children: [
            BottomNavigationBar(
              backgroundColor: const Color(0xfff9f9f9),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              selectedItemColor: const Color(0xff07c160),
              unselectedItemColor: const Color(0xff1c1c1c),
              currentIndex: logic.currentIndex.value,
              onTap: (value){
                logic.currentIndex.value = value;
                logic.pageController.jumpToPage(logic.currentIndex.value);
              },
              items: logic.items.map((e){
                BottomModel model = e;
                return BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 4,),
                    child: Image.asset(
                      "assets/images/bottom_${model.iconName}_c.png",
                      width: model.width,
                      height: model.height,
                    ),
                  ),
                  activeIcon: Container(
                    margin: const EdgeInsets.only(bottom: 4,),
                    child: Image.asset(
                      "assets/images/bottom_${model.iconName}_s.png",
                      width: model.width,
                      height: model.height,
                    ),
                  ),
                  label: model.label,
                );
              }).toList(),
            ),

            Positioned(
              left: ((MediaQuery.of(context).size.width/4)/2)+2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                decoration: const BoxDecoration(
                  color: Color(0xfffa5151),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: const Text(
                  "22",
                  style: TextStyle(
                    color: Color(0xffcfcfcf),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),



          ],
        );
      }),

      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: logic.pageController,
        onPageChanged: (index){
          logic.currentIndex.value = index;
        },
        children: logic.pages,
      ),
    );
  }
}
