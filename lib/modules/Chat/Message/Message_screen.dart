import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/Chat/Message/components/body.dart';

import 'package:helpy_app/shared/strings.dart';

import 'components/typing.dart';

class MessagesScreen extends StatelessWidget {
  final String myid, username, senderid, imageIntroduce;
  const MessagesScreen(
      this.myid, this.username, this.senderid, this.imageIntroduce);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodyMessage(userid: senderid, username: username, myid: myid),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            backgroundImage: NetworkImage(imageIntroduce),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(fontSize: 16),
                ),
                TypingMessage(myid: myid, senderid: senderid)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
