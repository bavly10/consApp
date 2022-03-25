import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
   cons_Cubit.get(context).getMyShared();
   var customerid= cons_Cubit.get(context).customerID;
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
                decoration: InputDecoration(labelText: "Send Message"),
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
    // Container(
    //   padding:const EdgeInsets.symmetric(
    //     horizontal: kDefaultPadding,
    //     vertical: kDefaultPadding / 2,
    //   ),
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).scaffoldBackgroundColor,
    //     boxShadow: [
    //       BoxShadow(
    //         offset:const Offset(0, 4),
    //         blurRadius: 32,
    //         color:const Color(0xFF087949).withOpacity(0.08),
    //       ),
    //     ],
    //   ),
    //   child: SafeArea(
    //     child: Row(
    //       children: [
    //         const Icon(Icons.mic, color: kPrimaryColor),
    //         const SizedBox(width: kDefaultPadding),
    //         Expanded(
    //           child: Container(
    //             padding:const EdgeInsets.symmetric(
    //               horizontal: kDefaultPadding * 0.75,
    //             ),
    //             decoration: BoxDecoration(
    //               color: kPrimaryColor.withOpacity(0.05),
    //               borderRadius: BorderRadius.circular(40),
    //             ),
    //             child: Row(
    //               children: [
    //                 const Expanded(
    //                   child: TextField(
    //                     decoration: InputDecoration(
    //                       hintText: "Type message",
    //                       border: InputBorder.none,
    //                     ),
    //                   ),
    //                 ),
    //                 Icon(
    //                   Icons.attach_file,
    //                   color: Theme.of(context)
    //                       .textTheme
    //                       .bodyText1!
    //                       .color!
    //                       .withOpacity(0.64),
    //                 ),
    //                 const SizedBox(width: kDefaultPadding / 4),
    //                 Icon(
    //                   Icons.camera_alt_outlined,
    //                   color: Theme.of(context)
    //                       .textTheme
    //                       .bodyText1!
    //                       .color!
    //                       .withOpacity(0.64),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
