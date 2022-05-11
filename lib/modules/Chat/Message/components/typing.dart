import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/shared/my_colors.dart';

class TypingMessage extends StatelessWidget {
  final String myid;
  TypingMessage({Key? key, required this.myid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fire = FirebaseFirestore.instance;
    return FutureBuilder(
        future: fire.collection("AllChat").doc(myid).get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.requireData.get("typing");
            var fstrem = FirebaseFirestore.instance
                .collection("AllChat")
                .doc(myid)
                .snapshots();
            return StreamBuilder(
                stream: fstrem,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (docs == "true") {
                    return const Text(
                      "Typing....",
                      style: TextStyle(fontSize: 12),
                    );
                  } else {
                    return const SizedBox();
                  }
                });
          } else {
            return CircularProgressIndicator(
              color: myAmber,
            );
          }
        });
  }
}
