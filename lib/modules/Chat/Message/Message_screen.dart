import 'package:flutter/material.dart';
import 'package:helpy_app/modules/Chat/Message/components/body.dart';
import 'package:helpy_app/shared/strings.dart';


class MessagesScreen extends StatelessWidget {
   final String myid,username,senderid;
  const MessagesScreen(this.myid,this.username, this.senderid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BodyMessage(),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          /// hn7ot hna image
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                 username,
                style: TextStyle(fontSize: 16),
              ),
                Text(
                "Active 1m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
