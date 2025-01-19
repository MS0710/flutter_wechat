import 'package:flutter/material.dart';
import 'package:flutter_wechat/widgets/close_bar.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPage();
  }

}

class _RegisterPage extends State<RegisterPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CloseBar(),
      body: const Center(
        child: Text("Coming soon"),
      ),
    );
  }

}