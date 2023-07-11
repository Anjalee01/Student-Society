import 'dart:async';
import 'dart:collection';
// import 'dart:js';

//import 'package:finalyearproject/Splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/Main/Splash_Screen.dart';
import 'package:finalyearproject/firebase_options.dart';
import 'package:finalyearproject/notificationController/notificationController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'SIGNUP/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices notificationServices = NotificationServices();
  notificationServices.initializeNotification();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance.collection("Create Event").snapshots();

    StreamSubscription<QuerySnapshot<Map<String, dynamic>>> streamSubscription =
        notificationStream.listen((event) {
      // return event;
      NotificationServices().sendNotification("Alert", "New Event Created");
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: SplashScreen(),
    );
  }
}
