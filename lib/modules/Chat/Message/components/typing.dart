import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/shared/my_colors.dart';

class TypingMessage extends StatelessWidget {
  final String myid, senderid;
  TypingMessage({Key? key, required this.myid, required this.senderid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllChat")
            .doc(myid)
            .collection('contact')
            .doc(senderid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitCircle(
              color: Colors.brown,
            );
          }
          final docs = snapshot.requireData.get("typing");
          if (docs == "true") {
            return const Text(
              "Typing....",
              style: TextStyle(fontSize: 12),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}