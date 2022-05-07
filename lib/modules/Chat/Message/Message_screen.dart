import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/Chat/Message/components/body.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

class MessagesScreen extends StatefulWidget {
  final String myid, username, senderid, imageIntroduce;
  const MessagesScreen(
      this.myid, this.username, this.senderid, this.imageIntroduce);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final fcm = FirebaseMessaging.instance;
    fcm.subscribeToTopic("AllChat");
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: BodyMessage(
            userid: widget.senderid,
            username: widget.username,
            myid: widget.myid),
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.imageIntroduce),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Active Now",
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
