//import 'package:finalyearproject/voulntere.dart';

import 'dart:convert';

import 'package:finalyearproject/Election/Vicepresidenet.dart';
import 'package:finalyearproject/Election/result%20screen.dart';
import 'package:finalyearproject/Election/votingchoice.dart';
import 'package:finalyearproject/Main/Splash_Screen.dart';
import 'package:finalyearproject/Volunteer/volunteerform.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Voting extends StatefulWidget {
  const Voting({Key? key}) : super(key: key);

  @override
  State<Voting> createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              // clipper: MyClipper(),
              child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.topCenter,
                  height: 553,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('img/voting.gif'),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text('Your vote MATTERS',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
                'The main objective of this society is to promote sports activities amongst the student of SZABIST Larkana. The society organizes sports activities on regular basis at the campus and outside the campus. All of the activities under this society are organized and executed by the students of University!!.',
                style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 15)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
                side: BorderSide(
                  width: 0.0,
                ),
                // elevation: 5,
                padding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () async {
                var redirect = false;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var getData =
                    await json.decode(prefs.getString("loginData") ?? "");
                final _db = FirebaseFirestore.instance;
                final snapshot =
                    await _db.collection('users').where("Email").get();
                print(snapshot.docs.map((e) {
                  // print(e.data());
                  // print(e.data()['email']);
                  if (e.data()['email'] == getData['email']) {
                    print(e.data()['voting']);
                    redirect = e.data()['voting'];
                    setState(() {});
                    if (e.data()['voting']) {}
                    print("Success");
                  }
                }));
                if (redirect) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResultsScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VicePresident()));
                }
              },
              child: const Center(
                child: Text(
                  ("Vote  Now"),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
