import 'package:chat_app/models/message.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {

  List<Message> messages;

  ChatSuccess({required this.messages});
}

final class ChatSendingMessage extends ChatState {}

final class ChatError extends ChatState {

  final String errMessage;

  ChatError({required this.errMessage});
}
