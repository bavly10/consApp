import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

class new_message extends StatefulWidget {
  final String userid,myid,username;

  const new_message(this.userid,this.myid,this.username);
  @override
  _new_messageState createState() => _new_messageState();
}

class _new_messageState extends State<new_message> {
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late TextEditingController controller;
  String _entermesage = "";

  _Sendmesage() async{
    FocusScope.of(context).unfocus();
   ConsCubit.get(context).getMyShared();
   var customerid= ConsCubit.get(context).customerID;
   final userdata= await FirebaseFirestore.instance.collection('users').doc(widget.userid).get();
    await FirebaseFirestore.instance.collection('AllChat').doc(customerid).collection("chats").doc(widget.userid).collection("mesage").add({
      "text":_entermesage,
      "senderid":widget.userid,
      "myid":customerid,
      "myname":widget.username,
      "username":userdata["username"],
      "image":userdata["imgurl"],
      "date":Timestamp.now(),
    });
    await FirebaseFirestore.instance.collection('fav_user').doc(widget.userid).collection("chats").doc(customerid).collection("mesage").add({
      "text":_entermesage,
      "senderid":widget.userid,
      "myid":customerid,
      "date":Timestamp.now(),
      "myname":widget.username,
      "username":userdata["username"],
      "image":userdata["imgurl"],
    });
    controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.myid);
    print(widget.userid);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset:const Offset(0, 4),
            blurRadius: 32,
            color:const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.mic, color: kPrimaryColor),
          const SizedBox(width: kDefaultPadding),
          Expanded(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(labelText: "Send Message"),
              )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _entermesage = controller.text;
                _entermesage.trim().isEmpty ? null : _Sendmesage();
              })
        ],
      ),
    );
  }
}
