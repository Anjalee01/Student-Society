import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationForm extends StatefulWidget {
  const NotificationForm({Key? key}) : super(key: key);

  @override
  _NotificationFormState createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Map<String, String?> selectedStatusMap = {};

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void saveStatusToFirebase(String eventName, String? selectedStatus) async {
    try {
      DocumentSnapshot eventSnapshot =
      await FirebaseFirestore.instance.collection('Event Happening').doc(eventName).get();

      if (eventSnapshot.exists) {
        Map<String, dynamic>? eventData =
        eventSnapshot.get('statusCountMap') as Map<String, dynamic>?;

        if (eventData != null) {
          print('eventData: $eventData');

          eventData[selectedStatus!] = (eventData[selectedStatus] as int? ?? 0) + 1;

          print('updated eventData: $eventData');

          await FirebaseFirestore.instance
              .collection('Event Happening')
              .doc(eventName)
              .update({'statusCountMap': eventData});

          print('Dropdown value saved to Firebase: $selectedStatus');
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Stream<DocumentSnapshot> getEventSnapshotStream(String eventName) {
    return FirebaseFirestore.instance
        .collection('Event Happening')
        .doc(eventName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Event Happening'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Create Event').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> eventData =
              document.data() as Map<String, dynamic>;
              final String eventName = eventData['EventName'];
              final String eventDescription = eventData['description'];

              return Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        eventName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Date: ${eventData['Date']}',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Time: ${eventData['time']}',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Location: ${eventData['location']}',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Description: $eventDescription',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      StreamBuilder<DocumentSnapshot>(
                        stream: getEventSnapshotStream(eventName),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Material(
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedStatusMap[eventName],
                                  hint: const Text('Select an option'),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedStatusMap[eventName] = newValue;
                                    });
                                    saveStatusToFirebase(eventName, newValue);
                                  },
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'Attending',
                                      child: const Text('Attending event'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Interested',
                                      child: const Text('Interested'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'NotGoing',
                                      child: const Text('Not going'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print('Snapshot error: ${snapshot.error}');
                          }

                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
