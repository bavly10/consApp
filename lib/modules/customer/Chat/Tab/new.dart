import 'package:flutter/material.dart';
import 'package:helpy_app/model/Chat.dart';
import 'package:helpy_app/modules/Chat/Message/Message_screen.dart';
import 'package:helpy_app/modules/Chat/components/chat_card.dart';
import 'package:helpy_app/shared/my_colors.dart';


class NewChat extends StatelessWidget {
  const NewChat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: mygrey,
      body: ListView.builder(
        itemCount: chatsData.length,
        itemBuilder: (context, index) => ChatCard(
          chat: chatsData[index],
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
