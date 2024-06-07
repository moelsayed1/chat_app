import 'dart:developer';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
            kMessage: message,
            kCreatedAt: DateTime.now(),
            kId: email,
          });
    } catch (e) {
      print(e);
    }
  }

  void getMessage() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {

      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      log('success');
      emit(ChatSuccess(
        messages: messagesList,
      ));
    });
  }
}
