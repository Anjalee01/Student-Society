import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? email;
  String? chat;
  String? id;

// receiving data
  ChatModel({this.id, this.email, this.chat});
  toJson() {
    return {"email": email, "chat": chat, "uid": id};
  }

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ChatModel(
      id: document.id,
      email: data['Email'],
      chat: data['chat'],
    );
  }

//  Future<ChatModel> fetchChatData(String email){
//  final snapshot =
//  }
}
