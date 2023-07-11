// import 'posts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'main.dart';
//
// class addnote extends StatelessWidget {
//   TextEditingController title = TextEditingController();
//
//   CollectionReference ref = FirebaseFirestore.instance.collection('posts');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           MaterialButton(
//             onPressed: () {
//               ref.add({
//                 'title': title.text,
//               }).whenComplete(() {
//                 Navigator.pushReplacement(
//                     context, MaterialPageRoute(builder: (_) => posts()));
//               });
//             },
//             child: Text(
//               "Post",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               height: 55,
//               decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                 BoxShadow(
//                     blurRadius: 10,
//                     spreadRadius: 7,
//                     offset: Offset(1, 1),
//                     color: Colors.purple.withOpacity(0.2))
//               ]),
//               // border: Border.all()),
//               child: TextField(
//                 controller: title,
//                 expands: true,
//                 maxLines: null,
//                 decoration: const InputDecoration(
//                   hintText: 'title',
//                   label: Text("Title"),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
