import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  String email;
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.email});
}
