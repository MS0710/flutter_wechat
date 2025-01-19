import 'package:flutter/material.dart';
import 'package:just_throttle_it/just_throttle_it.dart';

bool isInkWellProcessing = false;

void restoreProcess(){
  Future.delayed(const Duration(milliseconds: 500)).then((value) {
    isInkWellProcessing = false;
  });
}

void avoidRepeatingEvent(VoidCallback onTap){
  if(isInkWellProcessing){
    return;
  }
  isInkWellProcessing = true;
  restoreProcess();

  Throttle.milliseconds(1000,onTap);
}

///防止重複點擊
class ClickEvent extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const ClickEvent({required this.child,this.onTap,super.key});

  @override
  State<ClickEvent> createState() => _ClickEventState();
}

class _ClickEventState extends State<ClickEvent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.onTap == null){
          return;
        }

        if(isInkWellProcessing){
          return;
        }
        isInkWellProcessing = true;
        restoreProcess();

        Throttle.milliseconds(1000, widget.onTap!);
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Throttle.clear(widget.onTap!);
  }
}
