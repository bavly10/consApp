import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

class OldChat extends StatelessWidget {
  String? ahmed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mygrey,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("AllChat").where("myid",isEqualTo: cons_Cubit.get(context).customerID!).where("time",isGreaterThan:ahmed).snapshots(),
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
