import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class TypingMessage extends StatelessWidget {
  final String myid;
  TypingMessage({Key? key, required this.myid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
            return StreamBuilder(
                stream:  FirebaseFirestore.instance.collection("AllChat").doc(myid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitCircle(
                      color: Colors.brown,
                    );
                  }
                  final docs = snapshot.requireData.get("typing");
                  if (docs == "true") {
                    return Text(
                      mytranslate(context, "typing"),
                      style: const TextStyle(fontSize: 12),
                    );
                  }
                  else {
                    return Text(
                      mytranslate(context, "offline"),
                      style: const TextStyle(fontSize: 12),
                    );
                  }
                });
          }
  }

