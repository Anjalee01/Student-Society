
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/Volunteer/recievedata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
const List<String> list = <String>['Please select an option','BSCS', 'BSAF', 'BSMS', 'BBA'];



class Volunteerform extends StatefulWidget {

  Volunteerform({Key? key}) : super(key: key);


  @override
  State<Volunteerform> createState() => _VolunteerformState();
}

class _VolunteerformState extends State<Volunteerform> {
  String dropdownValue = list.first;

  String? value;
  String? items;
  @override
  final TextEditingController _fullnamecontroller = new TextEditingController();
  final TextEditingController _emailcontroller =new TextEditingController();
  final TextEditingController _phonenumbercontroller =new TextEditingController();
  final TextEditingController _registrationcontroller =new TextEditingController();
  final TextEditingController _departmentcontroller =new TextEditingController();
 final _auth = FirebaseAuth.instance;
 CollectionReference ref = FirebaseFirestore.instance.collection('Volunteering');
  String fullname ="";
  String phonenumber= "";
  String emailaddress =  "";
  String department =  "";
  String registration =  "";
  String dropdown = "";
  @override
  Widget build(BuildContext context) {
   // var buildMenuItem;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(

            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.grey,
                  Colors.grey,
                  Colors.grey,
                  Colors.grey
                ],
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Volunteer',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'ZAB E-FEST is an annual collaborative event organized by the Faculty of Computing & Engineering Sciences. '
                              'The 4th edition of ZAB E-FEST hosted over 1200 students from several universities in Karachi. The event '
                              'included CS Final Year Project, Speed Coding, Debugging, Treasure Hunt, Database, Workshops, and '
                              'Data-Science/AI competitions.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(225, 96, 27, 3),
                                        blurRadius: 10,
                                        offset: Offset(0, 10)),
                                  ],
                                ),
                                //
                              ),
                              TextFormField(
                                controller: _fullnamecontroller,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your full name';
                                  } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(
                                      value)) {
                                    return 'Please enter a valid full name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(


                                    hintText: 'Full Name',

                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30))),

                                onChanged: (value) {

                                  // do something
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _registrationcontroller,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  RegExp regex = new RegExp(r'^.{0,7}$');
                                  if (value!.isEmpty) {
                                    return "Please Enter the Registration ";
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("please enter valid Id min. 7 character");
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'Registration',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30))),
                                onChanged: (value) {

                                  // do something
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _phonenumbercontroller,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  RegExp regex = new RegExp(r'^\d{11}$');

                                  if (value!.isEmpty) {
                                    return "Please Enter the Mobile number ";
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("please enter valid Mob no: min. 11 character");
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'Mobile Number',


                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30))),
                                onChanged: (value) {



                                  // do something
                                },
                              ),


                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _emailcontroller,
                                validator: (value) {
                                  if (value!.length == 0) {
                                    return "Email cannot be empty";
                                  }
                                  if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please enter a valid email");
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email Address',
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30))),
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),


                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey, width: 1),
                                    borderRadius:BorderRadius.circular(50),

                                  ),

                                  child: DropdownButtonFormField<String>(
                                  // controller: _departmentcontroller,
                                    value: dropdownValue,
                                    // controller: _departmentcontroller,
                                    items: list.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),

                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        controller: _departmentcontroller;

                                        _departmentcontroller.text = newValue;


                                      });
                                    },
                                    decoration: InputDecoration(

                                      hintText: 'Select an option',

                                      contentPadding: const EdgeInsets.all(15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == 'Please select an option') {
                                        return 'Please select a department';
                                      } else {
                                        return null;
                                      }
                                    },

                                  ),
                              ),
                              Text(_departmentcontroller.text),

                                SizedBox(height: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:Colors.grey[400],
                                  side: BorderSide(
                                    width: 0.1,
                                  ),
                                  // elevation: 5,
                                  padding: const EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () {
                                 submit();
                                 },
                                child: const Center(
                                  child: Text(
                                    ("Submit"),
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ])),
      ),
    );
  }

Future submit() async{
    //var _formkey;
  final isValid = _formKey.currentState!.validate();
  if(!isValid) return;
  String message;
  try{
    final docuser = FirebaseFirestore.instance.collection("Volunteer");
    final data = {
      "fullname": _fullnamecontroller.text,
      "phonenumber": _phonenumbercontroller.text,
      "emailaddress": _emailcontroller.text,
      "registration": _registrationcontroller.text,
      "department": _departmentcontroller.text,

    };
    await docuser.add(data);
    message ='succussfully submitted voluntter';
    ScaffoldMessenger.of(context)
       .showSnackBar(SnackBar(content: Text(message.toString())));
  }
  catch (e){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));

  }

}}
