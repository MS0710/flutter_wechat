import 'package:flutter/material.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

import 'main_logic.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final MainLogic logic = Get.put(MainLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final double rateWidth = (MediaQuery.of(context).size.width-60)/2;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            )
        ),
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  "登入","註冊"
                ].map((e) {
                  final String valueStr = e == "登入"?"0":"1";
                  return ClickEvent(
                    onTap: () => logic.action(context,valueStr),
                    child: Container(
                      margin: valueStr == "0"
                          ? const EdgeInsets.symmetric(horizontal: 20)
                          : const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      width: rateWidth,
                      height: rateWidth *49/158,
                      decoration: BoxDecoration(
                        color: valueStr == "1" ? const Color(0xff07c160): Colors.white.withOpacity(0.12),
                        borderRadius: const BorderRadius.all(Radius.circular(9)),
                      ),
                      child: Text(
                        e,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
