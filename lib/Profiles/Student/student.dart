import 'package:finalyearproject/Certificate.dart';
import 'package:finalyearproject/Election/Voting.dart';
import 'package:finalyearproject/Posting/studentpostshhare.dart';
import 'package:finalyearproject/event/notifcation.dart';
import 'package:finalyearproject/SIGNUP/login.dart';
//import 'package:finalyearproject/pushnot.dart';
import 'package:finalyearproject/see_event.dart';
import 'package:finalyearproject/Profiles/Student/student_home.dart';
import 'package:finalyearproject/Volunteer/voulntere.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';

import '../../Volunteer/Task assgin.dart';

class student extends StatefulWidget {
  const student({Key? key}) : super(key: key);

  @override
  State<student> createState() => _studentState();
}

class _studentState extends State<student> {
  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Home"),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notification_add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationForm()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Student_Home(
                  //           id: 'id',
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Container(
                  //     height: 150,
                  //     width: MediaQuery.of(context).size.width / 2.5,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.grey[400],
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           spreadRadius: 5,
                  //           blurRadius: 7,
                  //           offset: Offset(0, 3), // changes position of shadow
                  //         ),
                  //       ],
                  //     ),
                  //     child: SingleChildScrollView(
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset(
                  //             "img/post.png",
                  //             height: 100, // Set the desired height
                  //             width: 180, // Set the desired width
                  //           ),
                  //           SizedBox(
                  //             height: 15,
                  //           ),
                  //           Text(
                  //             "Posts",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostingData(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "img/create.png",
                              height: 100, // Set the desired height
                              width: 100, // Set the desired width
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Updates",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => volunteer(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "img/vol.png",
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Volunteer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CertificateScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "img/bub.png",
                              height: 100,
                              width: 150,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Certificate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Voting(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "img/laa.png",
                                height: 90,
                                width: 160,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Voting",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskAssign(),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[400],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "img/ta.png",
                                height: 100,
                                width: 150,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Task assign",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 270, top: 90), // Adjust the padding as needed
                child: ElevatedButton.icon(
                  onPressed: _logout,
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 20,
                  ),
                  label: Text(""),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.grey[400],
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
