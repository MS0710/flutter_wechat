import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/im/im_sdk.dart';
import 'package:flutter_wechat/util/page/app_pages.dart';
import 'package:flutter_wechat/util/page/app_routers.dart';
import 'package:flutter_wechat/wechat_flutter.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  //確保主流程初始化
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogin = false;
  //ImSDK初始化
  await ImSdk.initSDK((bool value){
    isLogin = value;
  });
  runApp(MyApp(isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin,{super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("isLogin = $isLogin");
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin? AppRouters.rootPage : AppRouters.mainPage,
      navigatorKey: navigatorKey,
      getPages: AppPages.getPages,
    );
  }
}