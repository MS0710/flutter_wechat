import 'package:event_bus/event_bus.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

EventBus newMsgBus = EventBus();

class NewMsgBusModel{
  final String targetId;
  final V2TimMessage message;
  NewMsgBusModel(this.targetId,this.message);
}