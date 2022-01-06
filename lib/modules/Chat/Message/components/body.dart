import 'package:flutter/material.dart';
import 'package:helpy_app/model/ChatMessage.dart';
import 'package:helpy_app/shared/strings.dart';

import 'chat_input_field.dart';
import 'message.dart';

class BodyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}
