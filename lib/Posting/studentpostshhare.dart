import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostingData extends StatefulWidget {
  @override
  _PostingDataState createState() => _PostingDataState();
}

class _PostingDataState extends State<PostingData> {
  Map<String, bool> likeStatus = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
        backgroundColor: Colors.grey[400],
      ),
      body: Container(
        color: Colors.grey, // Set the background color to grey
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Posting').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Failed to fetch data'),
              );
            }

            final postData = snapshot.data!.docs;
            if (postData.isEmpty) {
              return Center(
                child: Text('No data found'),
              );
            }

            return ListView.builder(
              itemCount: postData.length,
              itemBuilder: (BuildContext context, int index) {
                final data = postData[index].data();
                final postId = postData[index].id;
                final title = data?['title'] ?? '';
                final description = data?['description'] ?? '';
                final imagePath = data?['imagePath'] ?? '';

                final isLiked = likeStatus[postId] ?? false;

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue, // Change the title color here
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black, // Change the description text color here
                          ),
                        ),
                        SizedBox(height: 10),
                        CachedNetworkImage(
                          imageUrl: imagePath,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: isLiked ? Colors.red : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  likeStatus[postId] = !isLiked;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.comment),
                              onPressed: () {
                                // Add your comment functionality here
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
