import 'package:scholar_chat/constant.dart';

class MessageModel {
  final String message;
  
  final String id;

  MessageModel({
    required this.message,
    
    required this.id,
  });

  factory MessageModel.fromjson(jsonData) {
    return MessageModel(
      message: jsonData[kMessage],
      
      id: jsonData['id'],
    );
  }
}
