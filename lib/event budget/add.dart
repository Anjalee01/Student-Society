import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventBudgetingPage extends StatefulWidget {
  @override
  _EventBudgetingPageState createState() => _EventBudgetingPageState();
}

class _EventBudgetingPageState extends State<EventBudgetingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPlace;
  int? _extraExpenses;
  int? _givenAmount;
  int _headMoney = 0;
  int _venueExpenses = 0;
  int _foodExpenses = 0;


  void _updateSelectedPlace(String value) {
    setState(() {
      _selectedPlace = value;
    });
  }

  void _updateExtraExpenses(String value) {
    setState(() {
      _extraExpenses = int.tryParse(value);
    });
  }

  void _updateGivenAmount(String value) {
    setState(() {
      _givenAmount = int.tryParse(value);
    });
  }

  void _updateVenueExpenses(String value) {
    setState(() {
      _venueExpenses = int.tryParse(value) ?? 0;
    });
  }

  void _updateFoodExpenses(String value) {
    setState(() {
      _foodExpenses = int.tryParse(value) ?? 0;
    });
  }

  // void _updateDrinkExpenses(String value) {
  //   setState(() {
  //     _drinkExpenses = int.tryParse(value) ?? 0;
  //   });
  // }

  int get _totalExpenses =>
      (_extraExpenses ?? 0) + _venueExpenses + _foodExpenses ;

  int get _profitOrLoss => (_givenAmount ?? 0) - _totalExpenses;

  void _submitBudgetDetails() async {
    if (_formKey.currentState!.validate()) {
      // Submit the budget details to Firestore
      try {
        await FirebaseFirestore.instance.collection('budgets').add({
          'event_name': _eventNameController.text, // Use the text value of the event name field
          'given_amount': _givenAmount,
          'event_place': _selectedPlace,
          'extra_expenses': _extraExpenses,
          'venue_expenses': _venueExpenses,
          'food_expenses': _foodExpenses,
          'total_expenses': _totalExpenses,
          'profit_or_loss': _profitOrLoss,
        });
        showToast('Budget has been successfully submitted.');
      } catch (error) {
        showToast('Error submitting the budget: $error');
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  final _eventNameController = TextEditingController();

  @override
  void dispose() {
    _eventNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event Budgeting'),
          backgroundColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'img/logoo.png', // Replace with your image file
                          width: 80,
                          height: 80,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Event Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Event name is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Given Amount'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _updateGivenAmount(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Given amount is required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';


                        }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Event Place'),
                value: _selectedPlace,
                items: [
                  DropdownMenuItem(child: Text('Szabist 100'), value: 'Szabist 100'),
                  DropdownMenuItem(child: Text('Szabist 99'), value: 'Szabist 99'),
                  DropdownMenuItem(child: Text('Szabist 154'), value: 'Szabist 154'),
                  DropdownMenuItem(child: Text('Szbaist 153'), value: 'Szabist 153'),

                ],
                onChanged: (value) => _updateSelectedPlace(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Event place is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Extra Things'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _updateExtraExpenses(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Event expenses are required';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'venue Expenses'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _updateVenueExpenses(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Venue expenses are required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Food & Drinks'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _updateFoodExpenses(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'expenses are required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
            Text('Profit/Loss: $_profitOrLoss'),
                Text(
                  'Remaining Money: ${_profitOrLoss >= 0 ? _profitOrLoss : 0}',
                ),SizedBox(height: 16),
                Text(
                  'Loss: ${_profitOrLoss < 0 ? _profitOrLoss.abs() : 0}',
                ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitBudgetDetails,
              child: Text('Submit'),
            ),
]
          ),
        ),
    ),
      ));
  }
}
