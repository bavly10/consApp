import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/shared/strings.dart';

import '../../../Chat/Message/Message_screen.dart';

class newTest extends StatefulWidget {
  const newTest({Key? key}) : super(key: key);

  @override
  _newTestState createState() => _newTestState();
}

class _newTestState extends State<newTest> {
  String? senderid,username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("AllChat").where("myid",isEqualTo: cons_Cubit.get(context).customerID!).snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitCircle(
              color: Colors.blue,
            );
          }
          final docs=snapshot.requireData.docs;
          return ListView.builder(
            itemBuilder: (ctx, index) =>
                InkWell(
                  onTap: (){
                    senderid=docs[index]['senderid'];
                    username = docs[index]['name'];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => MessagesScreen(cons_Cubit.get(context).customerID!,username!,senderid!)));
                    },
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
                    child: Row(
                      children: [
                        Stack(
                          children: const [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage("assets/images/user.png"),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  docs[index]['name'],
                                  style:
                                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 8),
                                const Opacity(
                                  opacity: 0.64,
                                  child: Text(
                                  "Hello Abdullah! I am...",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                         Opacity(
                          opacity: 0.64,
                          child: Text(docs[index]['senderid']),
                        ),
                      ],
                    ),
                  ),
                ),
            itemCount: docs.length,
          );
        },
      ),
    );
  }
}
