import 'package:finalyearproject/Election/Generalsecretory.dart';
import 'package:finalyearproject/Election/PresidentVote.dart';
import 'package:finalyearproject/Election/Representative.dart';
import 'package:finalyearproject/Election/Treasurer.dart';
import 'package:finalyearproject/Election/Vicepresidenet.dart';
import 'package:finalyearproject/Election/chatapp.dart';
//import 'package:finalyearproject/Election/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Votingchoice extends StatefulWidget {
  @override
  _VotingchoiceState createState() => _VotingchoiceState();
}

class _VotingchoiceState extends State<Votingchoice> {
  List<String> images = [
    'img/icon.png',
    "img/icon.png",
    "img/icon.png",
    "img/icon.png",
    "img/icon.png",
  ];

  List<String> des = [
    "As chief executive, the president presides over the cabinet and has responsibility for the management of the executive branch.!!",
    "The vice president of a company is usually the second or third in command and supports the President by overseeing internal operations and stepping in. !!",
    "the General Secretary is responsible for the day-to-day administration of the organization, managing its staff and overseeing its operations. !",
    "the Treasurer is responsible for the financial management of the organization. \nCreating and managing budget. \nFinancial oversight  !",
    "The role of a representative can vary depending on the context, but generally, a representative is someone who is chosen or elected to act on behalf of a group .!",
  ];

  Widget customcard(String langname, String image, String des) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        child: GestureDetector(
          child: InkWell(
            child: Material(
              color: Colors.grey,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          // changing from 200 to 150 as to look better
                          height: 150.0,
                          width: 150.0,
                          child: ClipOval(
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                image,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        langname,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: "Quando",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        des,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontFamily: "Alike"),
                        maxLines: 5,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Election",
            style: TextStyle(
              fontFamily: "Quando",
            ),
          ),
          backgroundColor: Colors.grey[400],
        ),
        body: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Navigate to the next page when the widget is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => President()),
                );
              },
              child: customcard("President", images[0], des[0]),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the next page when the widget is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VicePresident()),
                );
              },
              child: customcard("Vice President", images[1], des[1]),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the next page when the widget is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeneralSecretory()),
                );
              },
              child: customcard("General Secretary", images[2], des[2]),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the next page when the widget is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Treasurer()),
                );
              },
              child: customcard("Treasurer", images[3], des[3]),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the next page when the widget is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: customcard("Representative", images[4], des[4]),
            ),
          ],
        ));
  }
}
