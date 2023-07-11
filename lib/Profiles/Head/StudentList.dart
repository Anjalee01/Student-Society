import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('wrool', isEqualTo: 'Student')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Students'),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  final userData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  bool isUserEnabled = !(userData['disabled'] ??
                      false); // Check if user is enabled or disabled
                  return GestureDetector(
                    onTap: () {
                      if (!isUserEnabled) {
                        Fluttertoast.showToast(
                          msg: 'Your account is disabled.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
                      // Perform action when user is enabled
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docs[index]['email'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  child: Text("Deactivate User"),
                                  value: "deactivate",
                                ),
                                PopupMenuItem(
                                  child: Text("Activate User"),
                                  value: "activate",
                                ),
                              ],
                              onSelected: (value) async {
                                if (value == "activate") {
                                  await activateUser(
                                      snapshot.data!.docs[index]['email']);
                                } else if (value == "deactivate") {
                                  await deactivateUser(
                                      snapshot.data!.docs[index]['email']);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> deactivateUser(String email) async {
    try {
      final _db = FirebaseFirestore.instance;
      final snapshot = await _db.collection('users').get();
      print(snapshot.docs.map((e) => {
            print(e.data()['uid']),
            if (e.data()['email'] == email)
              {
                _db
                    .collection('users')
                    .doc(e.data()['uid'])
                    .update({"active": false}),
                // print(e.data()['voting']),
                // print("Success"),
                // print(e.data()['uid']),
                // print(e.data()),
                print("Success"),
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Deactivated")))
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ResultsScreen()),
                // )
              }
          }));
    } catch (e) {
      print('Failed to deactivate user: $e');
    }
  }

  Future<void> activateUser(String email) async {
    try {
      final _db = FirebaseFirestore.instance;
      final snapshot = await _db.collection('users').get();
      print(snapshot.docs.map((e) => {
            print(e.data()['uid']),
            if (e.data()['email'] == email)
              {
                _db
                    .collection('users')
                    .doc(e.data()['uid'])
                    .update({"active": true}),
                // print(e.data()['voting']),
                // print("Success"),
                // print(e.data()['uid']),
                // print(e.data()),
                print("Success"),
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Activated")))
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ResultsScreen()),
                // )
              }
          }));
    } catch (e) {
      print('Failed to activate user: $e');
    }
  }
}
