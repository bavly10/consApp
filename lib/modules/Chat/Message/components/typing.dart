import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TypingMessage extends StatelessWidget {
  final String myid;
  TypingMessage({Key? key, required this.myid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("AllChat").doc(myid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        final docs = snapshot.requireData.get("typing");
        if(docs=="true"){
          return const Text("Typing....",style: TextStyle(fontSize: 12),);
        }else{
          return const SizedBox();
        }

      },
    );
  }
}
