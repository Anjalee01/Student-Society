import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Recievedata extends StatefulWidget {
  @override
  _RecievedataState createState() => _RecievedataState();
}

class _RecievedataState extends State<Recievedata> {
  late TextEditingController _searchController;
  late TextEditingController _taskController;
  late String _searchText = '';
  late String loggedInUser = '';
  Set<String> assignedTasks = Set<String>();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _taskController = TextEditingController();
    retrieveLoggedInUser();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  void retrieveLoggedInUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        loggedInUser = user.displayName ?? '';
      });
    }
  }

  void assignTaskToUser(
      String userId, String task, String fullName, String email) {
    if (assignedTasks.contains(userId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task already assigned to $fullName'),
        ),
      );
    } else {
      FirebaseFirestore.instance.collection('TaskAssign').add({
        'userId': userId,
        'task': task,
        'fullName': fullName,
        'assignedBy': loggedInUser,
        'email': email
      }).then((_) {
        print("Assigned task to user with ID: $userId, Task: $task");
        setState(() {
          assignedTasks.add(userId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task assigned to $fullName'),
          ),
        );
      }).catchError((error) {
        print("Failed to assign task: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to assign task'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer List'),
        backgroundColor: Colors.grey[400],
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Search'),
                    content: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(hintText: 'Enter name'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _searchText = _searchController.text;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Search'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Volunteer').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.docs.where((doc) => doc
              .get('fullname')
              .toLowerCase()
              .contains(_searchText.toLowerCase()));
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final userId = data.elementAt(index).id;
              final fullName = data.elementAt(index).get('fullname');
              final department = data.elementAt(index).get('department');
              final phoneNumber = data.elementAt(index).get('phonenumber');
              final emailAddress = data.elementAt(index).get('emailaddress');
              final registration = data.elementAt(index).get('registration');
              final isTaskAssigned = assignedTasks.contains(userId);

              return Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      fullName,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone Number:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      phoneNumber,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      emailAddress,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Registration:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      registration,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Department:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      department.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Task Assigned By:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      loggedInUser,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _taskController,
                            enabled: !isTaskAssigned,
                            decoration: InputDecoration(
                              labelText: 'Task',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: isTaskAssigned
                              ? null
                              : () {
                                  final task = _taskController.text;
                                  assignTaskToUser(
                                      userId, task, fullName, emailAddress);
                                  _taskController.clear();
                                },
                          child: Text('Assign Task'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
