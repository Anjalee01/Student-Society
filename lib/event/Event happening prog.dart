import 'dart:async';

import 'package:finalyearproject/notificationController/notificationController.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventAttendanceStatusScreen extends StatefulWidget {
  @override
  State<EventAttendanceStatusScreen> createState() =>
      _EventAttendanceStatusScreenState();
}

class _EventAttendanceStatusScreenState
    extends State<EventAttendanceStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Attendance Status'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Event Happening')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final List<DocumentSnapshot> eventDocs = snapshot.data!.docs;

          if (eventDocs.isEmpty) {
            return Text('No events found');
          }

          return ListView.builder(
            itemCount: eventDocs.length,
            itemBuilder: (BuildContext context, int index) {
              final eventDoc = eventDocs[index];
              final eventData = eventDoc.data() as Map<String, dynamic>;
              final String eventName = eventDoc.id;
              final Map<String, dynamic> statusCountMap =
                  (eventData['Event Happening'] as Map<String, dynamic>?) ?? {};

              final int attendingCount = statusCountMap['Attending'] ?? 0;
              final int interestedCount = statusCountMap['Interested'] ?? 0;
              final int notGoingCount = statusCountMap['NotGoing'] ?? 0;

              return ListTile(
                title: Text(eventName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Attending: $attendingCount'),
                    Text('Interested: $interestedCount'),
                    Text('Not Going: $notGoingCount'),
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
