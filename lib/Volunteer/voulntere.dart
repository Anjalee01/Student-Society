//import 'package:finalyearproject/voulntere.dart';
import 'package:finalyearproject/Main/Splash_Screen.dart';
import 'package:finalyearproject/Volunteer/volunteerform.dart';
import 'package:flutter/material.dart';

class volunteer extends StatefulWidget {
  const volunteer({Key? key}) : super(key: key);

  @override
  State<volunteer> createState() => _volunteerState();
}

class _volunteerState extends State<volunteer> {
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
                      image: AssetImage('img/volunteer.png'),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text('Volunteering and its Surprising Benefits',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
                'Volunteering can help you make friends, learn new skills,'
                ' advance your career, and even feel happier and healthier.'
                'so what are waiting for Apply now',
                style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 15)),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[400],
                side: BorderSide(
                  width: 0.1,
                ),
                // elevation: 5,
                padding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                // Voulntere();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Volunteerform()));
                // add(title, description);
              },
              child: const Center(
                child: Text(
                  ("Apply Now"),
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
