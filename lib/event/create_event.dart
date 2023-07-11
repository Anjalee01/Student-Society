import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
//     as example;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/material/date_picker_theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:finalyearproject/Profiles/Head/Head.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'metting_data_source.dart';

class createeventScreen extends StatefulWidget {
  const createeventScreen({Key? key}) : super(key: key);

  @override
  State<createeventScreen> createState() => _createeventScreenState();
}

class _createeventScreenState extends State<createeventScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titlecontroller = new TextEditingController();
  final TextEditingController _locationcontroller = new TextEditingController();
  final TextEditingController _descriptioncontroller =
      new TextEditingController();
  final TextEditingController _Date = new TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController datController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('event');

  String title = "";
  String location = "";
  String description = "";

  DateTime? fDOB, fDate;
  TimeOfDay? fTime;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CalendarAppBar(
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CREATE EVENT!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _titlecontroller,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == "") {
                          return 'title Cannot be Empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Event Name",
                        label: Text("event name"),
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _locationcontroller,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == "") {
                          return 'please enter the szab location';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "location",
                        label: Text("Location"),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.location_city),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 4,
                      controller: _descriptioncontroller,
                      decoration: InputDecoration(
                        hintText: "description",
                        label: Text("description"),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: datController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: "Enter Date",
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            selectTime(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextFormField(
                              enabled: false,
                              controller: _time,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                labelText: 'Time',
                                hintText: 'Time',
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[400],
                        elevation: 5,
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        submit();
                      },
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // selectDate(BuildContext context, int index) async {
  //   DateTime? selectDate;
  //   await example.DatePicker.showDatePicker(context,
  //       showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
  //     selectDate = date;
  //   }, currentTime: DateTime.now());
  //   //  DatePicker.showDatePicker(context,
  //   //     showTitleActions: true,
  //   //     minTime: DateTime(2018, 3, 5),
  //   //     maxTime: DateTime(2019, 6, 7), onChanged: (date) {
  //   //   print('change $date');
  //   // }, onConfirm: (date) {
  //   //   print('confirm $date');
  //   // }, currentTime: DateTime.now(), locale: LocaleType.zh);

  //   if (selectDate != null) {
  //     setState(() {
  //       if (index == 1) {
  //         _Date.text = DateFormat('dd/MM/yyyy').format(selectDate!);
  //         fDate = selectDate;
  //       }
  //     });
  //   }
  // }

  selectTime(BuildContext context) async {
    TimeOfDay? selectTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectTime != null) {
      setState(() {
        _time.text = selectTime.format(context);
        fTime = selectTime;
      });
    }
  }

  Future submit() async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) return;
    String message;
    try {
      final docuser = FirebaseFirestore.instance.collection('Create Event');
      final data = {
        'EventName': _titlecontroller.text,
        'description': _descriptioncontroller.text,
        'location': _locationcontroller.text,
        'time': _time.text,
        'Date': datController.text,
      };
      await docuser.add(data);
      message = 'Successfully created Event';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message.toString())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
