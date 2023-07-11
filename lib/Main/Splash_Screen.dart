import 'dart:async';
import 'package:finalyearproject/SIGNUP/login.dart';
import 'package:finalyearproject/SIGNUP/register.dart';
import 'package:flutter/material.dart';
import 'package:finalyearproject/Main/Splash_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder(
                //future: checkLoginStatus(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data == false) {
                      return LoginPage();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          color: Colors.white,
                          child: Center(child: CircularProgressIndicator()));
                    }
                    return LoginPage();
                  })));

      // Navigator.push(context, MaterialPageRoute(builder:(context)=>Page1()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [Image.asset("img/logoo.png")],
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'University Student societies',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Version: 1.0.0',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
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

  String intTo8bitString(int number, {bool prefix = false}) => prefix
      ? '0x${number.toRadixString(2).padLeft(19, '0')}'
      : '${number.toRadixString(2).padLeft(19, '0')}';
}
