import 'package:chat_app/core/app_strings.dart';

class Message {
  final String message;
  final createdTime;
  final  id ;

  Message({required this.message, required this.createdTime , required this.id});

  factory Message.formJson(jsonData) {
    return Message(
      message: jsonData[AppStrings.kMessage],
      createdTime: jsonData[AppStrings.timeCreated] ,
      id : jsonData[AppStrings.id] ,
    );
  }
}
