import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationScreen extends StatefulWidget {
  @override
  _PushNotificationScreenState createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imagePath;
  bool _isUploading = false;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  Future<void> _uploadImageAndSubmitForm() async {
    if (_formKey.currentState!.validate() && _imagePath != null) {
      setState(() {
        _isUploading = true;
      });

      final title = _titleController.text;
      final description = _descriptionController.text;

      try {
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now()}.jpg');
        final uploadTask = storageRef.putFile(File(_imagePath!));
        final snapshot = await uploadTask.whenComplete(() => null);
        final imageUrl = await snapshot.ref.getDownloadURL();

        FirebaseFirestore.instance.collection('Posting').add({
          'title': title,
          'description': description,
          'imagePath': imageUrl,
        }).then((value) {
          // Data saved successfully
          // Reset the form and navigate back to the previous screen
          _formKey.currentState!.reset();
          _titleController.clear();
          _descriptionController.clear();
          setState(() {
            _imagePath = null;
            _isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Post created successfully!')),
          );
        }).catchError((error) {
          // Error occurred while saving data
          // Handle the error
          setState(() {
            _isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to create notification. Please try again.')),
          );
        });
      } catch (error) {
        // Error occurred while uploading image
        // Handle the error
        setState(() {
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          "img/logoo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Create post',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: Text(
                          _imagePath != null ? 'Change Image' : 'Pick Image'),
                    ),
                    SizedBox(width: 16),
                    _isUploading
                        ? CircularProgressIndicator() // Show a progress indicator during image upload
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: _uploadImageAndSubmitForm,
                              style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .grey, // Set the background color to grey
                              ),
                              child: Container(
                                width: 80,
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
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
}
