import 'package:finalyearproject/Posting/Post.dart';
import 'package:finalyearproject/Volunteer/recievedata.dart';
import 'package:finalyearproject/event%20budget/add.dart';
import 'package:finalyearproject/event/create_event.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../event/Event happening prog.dart';
import 'StudentList.dart';
import '../../posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../SIGNUP/login.dart';
import '../../Rools/model.dart';

class Head extends StatefulWidget {
  String id;
  Head({required this.id});
  @override
  _HeadState createState() => _HeadState(id: id);
}

class _HeadState extends State<Head> {
  String id;
  var rooll;
  var emaill;
  var fullName;
  UserModel loggedInUser = UserModel();
  var user = FirebaseAuth.instance.currentUser!;
  _HeadState({required this.id});
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
        fullName = loggedInUser.fullName.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10), // set the padding as needed
            child: Image.asset(
              "img/logoo.png",
              height: 40, // set the height of the logo as needed
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              height: 220,
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xff3F5069),
                          Color.fromARGB(255, 99, 125, 165),
                          Color.fromARGB(255, 141, 178, 233),
                        ],
                      )),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 25,
                    left: 25,
                    child: SizedBox(
                      height: 140,
                      width: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 25.0,
                                offset: Offset(0, -10))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GradientText(
                              "${user.displayName}",
                              style: TextStyle(
                                  fontSize: 28.0, fontWeight: FontWeight.bold),
                              colors: [
                                Color(0xff3F5069),
                                Color.fromARGB(255, 99, 125, 165),
                                Color.fromARGB(255, 141, 178, 233),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: SelectCard(choice: choices[index]),
                  );
                })),
          ],
        ),
      ), // body: Center(
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon, required this.navi});
  final String title;
  final IconData icon;
  final navi;
}

List<Choice> choices = <Choice>[
  Choice(
      title: 'Event Budget',
      icon: Icons.money,
      navi: EventBudgetingPage(
          //trainerId: trainerId,
          )),
  Choice(
      title: 'Create Event',
      icon: Icons.event,
      navi: createeventScreen(
          // trainerId: trainerId,
          )),
  Choice(
      title: 'Student list',
      icon: Icons.person_2_rounded,
      navi: StudentList(
          // trainerId: trainerId,
          )),
  // Choice(
  //     title: 'Post/share',
  //     icon: Icons.post_add,
  //     navi: posts(
  //       //trainerId: trainerId,
  //     )),
  Choice(title: 'Volunteer data', icon: Icons.date_range, navi: Recievedata()),
  Choice(
      title: 'Post/Updates',
      icon: Icons.date_range,
      navi: PushNotificationScreen()),
  Choice(
      title: 'Event Happening',
      icon: Icons.person_2_rounded,
      navi: EventAttendanceStatusScreen(
          // trainerId: trainerId,
          )),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => choice.navi),
        );
      },
      child: Card(
          color: Colors.grey[300],
          elevation: 20,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Icon(
                    choice.icon,
                    color: Colors.black,
                    size: 50.0,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      choice.title,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ]),
          )),
    );
  }
}
