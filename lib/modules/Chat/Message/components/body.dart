import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/Message/components/mesage_buble.dart';
import 'package:helpy_app/modules/Chat/Message/components/typing.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/strings.dart';

import 'chat_input_field.dart';

class BodyMessage extends StatelessWidget {
  final String userid, username, myid;
  final ScrollController _controller = ScrollController();
  String? anotherid;
  BodyMessage(
      {Key? key,
      required this.userid,
      required this.username,
      required this.myid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("AllChat").doc(myid).collection("chats").doc(userid).collection("message").orderBy("date", descending: true).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitCircle(
            color: Colors.brown,
          );
        }
        final docs = snapshot.requireData.docs;
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ListView.builder(
                  controller: _controller,
                  reverse: true,
                  itemCount: docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      BlocBuilder<ConsChat, ConsChatStates>(
                    builder: (ctx, state) {
                      final cubit = ConsChat.get(context);
                      return mesagebuble(
                        username: docs[index]['myname'],
                        mesage: docs[index]['text'],
                        useriamg: docs[index]['image'],
                        date: docs[index]['date'],
                        isme: docs[index]['senderid'] == myid,
                        isopen: cubit.isopen,
                        read: docs[index]['read'],
                      );
                    },
                  ),
                ),
              ),
            ),
            ChatInputField(
              userid: userid,
              username: username,
              custid: myid,
              listController: _controller,
            )
          ],
        );
      },
    );
  }
}
