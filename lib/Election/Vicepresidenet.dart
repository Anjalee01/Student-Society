import 'package:finalyearproject/Election/PresidentVote.dart';
import 'package:finalyearproject/Election/Treasurer.dart';
import 'package:finalyearproject/Election/result%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VicePresident extends StatefulWidget {
  @override
  _VicePresidentState createState() => _VicePresidentState();
}

class _VicePresidentState extends State<VicePresident> {
  bool _isVoted = false;

  set isVoted(bool newValue) {
    setState(() {
      _isVoted = newValue;
    });
  }

  // rest of the code

  int _selectedOption = -1;
  bool _submitted = false;
  int _totalVotes = 0;
  bool _nextEnabled = false;

  Future<void> _submitVote(String name) async {
    final docRef =
    FirebaseFirestore.instance.collection('Election').doc('Vice President');
    final docSnapshot = await docRef.get();
    final Map<String, dynamic> data = docSnapshot.data() ?? {};
    final int currentCount = data.containsKey(name) ? data[name] : 0;
    await docRef.set({name: currentCount + 1}, SetOptions(merge: true));
    await FirebaseFirestore.instance.collection('Election').add({
      'Vice President': name,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _fetchTotalVotes() async {
    final docRef =
    FirebaseFirestore.instance.collection('Election').doc('Vice President');
    final docSnapshot = await docRef.get();
    final Map<String, dynamic> data = docSnapshot.data() ?? {};
    num total = 0;
    data.values.forEach((count) => total += count);
    setState(() {
      _totalVotes = total.toInt();
    });
  }

  void _handleCheckboxChange(int option) {
    if (!_submitted) {
      setState(() {
        _selectedOption = option;
        _nextEnabled = true;
      });
    }
  }

  void _handleSubmit() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to vote.')),
      );
      return;
    }

    final votesCollection =
    FirebaseFirestore.instance.collection('Votes');
    final voteQuerySnapshot = await votesCollection
        .where('userId', isEqualTo: user.uid)
        .limit(1)
        .get();
    if (voteQuerySnapshot.docs.isNotEmpty) {
      setState(() {
        isVoted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have already voted.')),
      );
      return;
    }

    setState(() {
      _submitted = true;
    });
    await _submitVote(_getSelectedName());
    await _fetchTotalVotes();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Submitted'),
      duration: Duration(seconds: 2),
    ));
  }

  String _getSelectedName() {
    switch (_selectedOption) {
      case 1:
        return 'Deepa Ghai';
      case 2:
        return 'Hafsa khan';
      case 3:
        return 'Ammar Khan';
      case 4:
        return 'Ibrahim Hassan';
      default:
        return '';
    }
  }

  Widget _buildResultBar(String name, int count) {
    double percentage = _totalVotes == 0 ? 0 : count / _totalVotes;
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            count.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchTotalVotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polling Booth'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Vote for Your Fav Vice President:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('img/12.jpg'),
            ),
            title: const Text('Deepa Ghai'),
            trailing: Checkbox(
              value: _selectedOption == 1,
              onChanged: _submitted
                  ? null
                  : (newValue) {
                _handleCheckboxChange(1);
              },
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('img/12.jpg'),
            ),
            title: const Text('Hafsa khan'),
            trailing: Checkbox(
              value: _selectedOption == 2,
              onChanged: _submitted
                  ? null
                  : (newValue) {
                _handleCheckboxChange(2);
              },
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('img/12.jpg'),
            ),
            title: const Text('Ammar Khan'),
            trailing: Checkbox(
              value: _selectedOption == 3,
              onChanged: _submitted
                  ? null
                  : (newValue) {
                _handleCheckboxChange(3);
              },
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('img/12.jpg'),
            ),
            title: const Text('Ibrahim Hassan'),
            trailing: Checkbox(
              value: _selectedOption == 4,
              onChanged: _submitted
                  ? null
                  : (newValue) {
                _handleCheckboxChange(4);
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
            _selectedOption == -1 || _submitted ? null : _handleSubmit,
            child: const Text('Submit'),
          ),
          Visibility(
            visible: _submitted && _nextEnabled,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => President()),
                );
                // Handle navigation to the next page here
              },
              child: const Text('Next'),
            ),
          ),
          if (_submitted) const SizedBox(height: 20),
          if (_submitted)
            const Text(
              'Thank you for voting!',
              style: TextStyle(fontSize: 20),
            ),
        ],
      ),
    );
  }
}