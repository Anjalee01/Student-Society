import 'package:finalyearproject/Election/Treasurer.dart';
import 'package:finalyearproject/Election/chatapp.dart';
import 'package:finalyearproject/Profiles/Student/student.dart';
import 'package:finalyearproject/Profiles/Student/student_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<ResultSection> _resultSections = [];

  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<void> _fetchResults() async {
    List<String> collectionNames = [
      'President',
      'Vice President',
      'Representative',
      'Treasurer',
      'GeneralSecretory'
    ];

    List<ResultSection> resultSections = [];

    for (String collectionName in collectionNames) {
      final docRef =
          FirebaseFirestore.instance.collection('Election').doc(collectionName);
      final docSnapshot = await docRef.get();
      final Map<String, dynamic> data = docSnapshot.data() ?? {};

      List<ResultItem> results = [];
      data.forEach((candidate, votes) {
        results.add(ResultItem(candidate: candidate, votes: votes));
      });

      resultSections.add(ResultSection(
        title: collectionName,
        results: results,
      ));
    }

    setState(() {
      _resultSections = resultSections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Election Results'),
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(
            Icons.home, // Replace with the desired home icon
            size: 24,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => student()),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                icon: Icon(Icons.chat)),
          )
        ],
      ),
      body: Center(
        child: ListView.separated(
          itemCount: _resultSections.length,
          itemBuilder: (context, sectionIndex) {
            final section = _resultSections[sectionIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    section.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: section.results.length,
                  itemBuilder: (context, index) {
                    final result = section.results[index];
                    final totalVotes = section.results
                        .map((result) => result.votes)
                        .reduce((a, b) => a + b);
                    final percentage = (result.votes / totalVotes) * 100;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('img/12.jpg'),
                      ),
                      title: Text(result.candidate),
                      subtitle: LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      trailing: Text('${result.votes} votes'),
                    );
                  },
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 16),
        ),
      ),
    );
  }
}

class ResultSection {
  final String title;
  final List<ResultItem> results;

  ResultSection({required this.title, required this.results});
}

class ResultItem {
  final String candidate;
  final int votes;

  ResultItem({required this.candidate, required this.votes});
}
