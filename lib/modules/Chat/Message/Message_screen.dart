import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/Chat/Message/components/body.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/strings.dart';


class MessagesScreen extends StatelessWidget {
   final String myid,username,senderid,imageIntroduce;
  const MessagesScreen(this.myid,this.username, this.senderid,this.imageIntroduce);

  @override
  Widget build(BuildContext context) {
    final fcm=FirebaseMessaging.instance;
    fcm.subscribeToTopic("AllChat");
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodyMessage(userid:senderid,username:username,myid:myid ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
           CircleAvatar(backgroundImage: NetworkImage(imageIntroduce),),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                username,
                style: const TextStyle(fontSize: 16),
              ),
               Text(
                "Active Now",
                style: TextStyle(fontSize: 12,color: Colors.grey[500]),
              )
            ],
          )
        ],
      ),
    );
  }
}
