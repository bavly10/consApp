import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/Chat/Message/Message_screen.dart';
import 'package:helpy_app/modules/Chat/components/chat_card.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

class OldChat extends StatelessWidget {
  const OldChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mygrey,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return  Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget> [
                  Text("Loading..."),
                  SizedBox(
                    height: 50.0,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            final list=snapshot.requireData.docs;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) =>InkWell(
                onTap:(){},
                child: Padding(
                  padding:const  EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
                  child: Row(
                    children: [
                      Stack(
                        children: const [
                         CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage("assets/logo.png"),
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
                                list[index]["username"],
                                style:
                                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              const Opacity(
                                opacity: 0.64,
                                child: Text(
                                  "chat.lastMessage",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Opacity(
                        opacity: 0.64,
                        child: Text("8m ago"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
