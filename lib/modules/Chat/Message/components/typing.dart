import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

class TypingMessage extends StatelessWidget {
  final String username;
    TypingMessage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsChat, ConsChatStates>(
        builder: (ctx, state) {
          final cubit=ConsChat.get(context).isopen;
          if(cubit){
            return Container(
              //  width: 100,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 0.90,
                vertical: kDefaultPadding / 6,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0)
                ),
                color: myAmber ,
              ),
              child:  Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  "$username Typing....",
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}
