import 'package:event_bus/event_bus.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

EventBus covBus = EventBus();

class CovBusModel{
  final String targetId;
  final V2TimMessage message;

  CovBusModel(this.targetId,this.message);
}

class CovSetReadModel{
  final String targetId;

  CovSetReadModel(this.targetId);
}