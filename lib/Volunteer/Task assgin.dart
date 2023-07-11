import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskAssign extends StatefulWidget {
  @override
  _TaskAssignState createState() => _TaskAssignState();
}

class _TaskAssignState extends State<TaskAssign> {
  @override
  Widget build(BuildContext context) {
    var getData;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      getData = await json.decode(prefs.getString("loginData") ?? "");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Assign'),
        backgroundColor: Colors.grey[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('TaskAssign').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data!.docs;
            print(data.map((e) => {print(e.data())}));
            return Column(
              children: [
                _buildTaskImage(),
                Expanded(
                  child: ListView.builder(
                    // separatorBuilder: (BuildContext context, int index) =>
                    // Divider(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final taskData =
                          data.elementAt(index).data() as Map<String, dynamic>?;
                      if (taskData == null) {
                        return SizedBox();
                      }
                      final assignedBy = taskData['assignedBy'] as String?;
                      final assignedTo = taskData['fullName'] as String?;
                      final task = taskData['task'] as String?;
                      final email = taskData['email'] as String?;

                      return Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: email == getData['email']
                            ? Column(
                                children: [
                                  Divider(),
                                  _buildAssignedBy(assignedBy),
                                  SizedBox(height: 10),
                                  _buildAssignedTo(assignedTo),
                                  SizedBox(height: 10),
                                  _buildTask(task),
                                  SizedBox(height: 10),
                                  _buildEmail(email)
                                ],
                              )
                            : Container(),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskImage() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'img/task.png'), // Replace with the asset path of your PNG image
          fit: BoxFit.fill,
          alignment: Alignment.topCenter, // Align the image to the top
        ),
      ),
    );
  }

  Widget _buildAssignedBy(String? assignedBy) {
    return Text(
      'Task Assigned By: ${assignedBy ?? ""}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildAssignedTo(String? assignedTo) {
    return Text(
      'Task Assigned To: ${assignedTo ?? ""}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTask(String? task) {
    return Text(
      'Task: ${task ?? ""}',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget _buildEmail(String? task) {
    return Text(
      'Email: ${task ?? ""}',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }
}
