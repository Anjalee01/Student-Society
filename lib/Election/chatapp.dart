import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/Election/chatModel.dart';
import 'package:finalyearproject/notificationController/notificationController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:finalyearproject/Election/chatMessage.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController = TextEditingController();
  // List<String> _messages = [];
  // String _loggedInUser =
  //     "Display"; // Example: Replace with your logged-in user's name

  // void _sendMessage(String message) {
  //   setState(() {
  //     _messages.add('$_loggedInUser: $message');
  //     _textEditingController.clear();
  //   });
  // }

  // Widget _buildChatMessageList() {
  //   return ListView.builder(
  //     itemCount: _messages.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(_messages[index]),
  //       );
  //     },
  //   );
  // }

  List messages = [
    {
      "messageContent":
          "Hello, Will asfsa wq erfsc asa fdsa fewq safsadf qefdsf",
      "messageType": "receiver",
      "email": "abc@gmail.caom",
      "name": "Ahmed Khan",
    },
    {
      "messageContent": "Hello, Will",
      "messageType": "receiver",
      "name": "Deepa Ghai",
      "email": "abc@gmail.caom",
    },
    {
      "messageContent":
          "Hello, Will ,adsf asdf saf eqf dsaf dsafdsaf fe fdsa fcads fae fascxzcbnf",
      "messageType": "sender",
      "name": "Bilal Khan",
      "email": "abc@gmail.caom",
    },
    {
      "messageContent": "Hello, Will",
      "messageType": "receiver",
      "name": "Kamran",
      "email": "abc@gmail.caom",
    },
    {
      "messageContent": "Hello, Will",
      "messageType": "sender",
      "name": "Babar Azam",
      "email": "abc@gmail.caom",
    },
  ];

  // final getData;
  // @override
  // void initState() async {
  //   super.initState();
  // }
  // Future<dynamic> sharedData() async {
  //   print("object");
  //   print(getData['email']);
  //   print("object");
  //   return (await getData['email']);
  // }

  @override
  Widget build(BuildContext context) {
    var getData;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      getData = await json.decode(prefs.getString("loginData") ?? "");
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("img/logoo.png"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Group Chat",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     NotificationServices()
                //         .sendNotification("Abdur", "New Event Created");
                //   },
                //   icon: Icon(
                //     Icons.call,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              // .orderBy('createdAt', descending: true)
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      // print(doc['Email'].runtimeType);
                      // print(doc['Email']);
                      // print(getData['email']);

                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          // alignment: Alignment.topLeft,
                          alignment: (getData['email'] == doc['Email']
                              ? Alignment.topRight
                              : Alignment.topLeft),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: getData['email'] == doc['Email']
                                    ? Radius.circular(20)
                                    : Radius.circular(0),
                                bottomRight: getData['email'] == doc['Email']
                                    ? Radius.circular(0)
                                    : Radius.circular(20),
                              ),
                              color: (getData['email'] == doc['Email']
                                  ? Color.fromRGBO(51, 61, 86, 1)
                                  : Color.fromARGB(255, 202, 202, 202)),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['Email'],
                                  style: GoogleFonts.alike(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      color: (getData['email'] == doc['Email']
                                          ? Colors.white
                                          : Colors.black),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    doc['chat'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: (getData['email'] == doc['Email']
                                            ? Colors.white
                                            : Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No Messages"));
                }
              },
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // height: 50,
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xFF333D56),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 12.0),
                    child: Transform.rotate(
                        angle: 45,
                        child: const Icon(
                          Icons.attach_file_sharp,
                          color: Colors.white,
                        )),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: chatController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 6,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 11.0),
                    child: Transform.rotate(
                      angle: -3.14 / 5,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var getData = await json
                                .decode(prefs.getString("loginData") ?? "");
                            // print("getData");
                            print("getData");
                            print(getData);
                            print("getData");
                            if (chatController.text != "") {
                              chat(getData['email'], chatController.text);
                              chatController.clear();
                            }
                          },
                          onLongPress: () {
                            setState(() {
                              // messageList.add(
                              //     MessageData(textEditingController.text, false));
                              // textEditingController.clear();
                              // scrollAnimation();
                            });
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future chat(String email, String message) async {
    //  final _db = FirebaseFirestore.instance;
    // final snapshot = await _db.collection('Chats').where("Email").get();
    // print(snapshot.docs.map((e) => print(e.data() )));

    // final data =
    //     await snapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList();
    // print(await data);
    // Stream collectionStream =
    //     await FirebaseFirestore.instance.collection('Chats').snapshots();
    // print(await collectionStream);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getData = await json.decode(prefs.getString("loginData") ?? "");

    //      final _db = FirebaseFirestore.instance;
    // final snapshot = await _db.collection('Chats').get();
    // snapshot.docs.map((e) {
    //   print(e.data() == "");
    //   print(e.data() );

    //   // print(e.data()['email']);
    //   // if (e.data()['email'] == getData['email']) {
    //   //   _db.collection('users').doc(e.data()['uid']).update({"voting": true});
    //   //   print(e.data()['voting']);
    //   //   print("Success");
    //   // }
    // });
    print("Time");
    print(DateTime.now().toUtc());
    print("Time");

    try {
      final chat = FirebaseFirestore.instance.collection('Chats');
      final data = {
        'Email': email,
        'chat': message,
        'createdAt': DateTime.now().toUtc(),
      };
      await chat.add(data);
      // message = 'Successfully created Event';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sent")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}


// void main() {
//   runApp(MaterialApp(
//     home: ChatScreen(),
//   ));
// }
