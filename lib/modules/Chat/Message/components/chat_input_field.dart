import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:helpy_app/shared/my_colors.dart';


class ChatInputField extends StatelessWidget {
  final String userid,username;
   TextEditingController controller=TextEditingController();
   ChatInputField({Key? key,  required this.userid,required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsChat,ConsChatStates>(
      builder: (ctx,state){
        final cubit=ConsChat.get(context);
        return Container(
          padding:const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 6,
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
          child: SafeArea(
            child: Row(
              children: [
                cubit.isopen?IconButton(
                    icon: const Icon(Icons.send,color: kPrimaryColor),
                    onPressed: () {
                      cubit.message!.trim().isEmpty ? null : cubit.sendMessage(context: context,userid: userid, username: username).then((value) => controller.clear());
                    }):const
                Icon(Icons.mic, color: kPrimaryColor),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  child: Container(
                    padding:const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:TextField(
                            controller:controller,
                            onChanged: (s){
                              cubit.changeIcon(s);
                            },
                            decoration: InputDecoration(
                              hintText: mytranslate(context, "typemessage"),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
                        ),
                        const SizedBox(width: kDefaultPadding / 4),
                        Icon(Icons.camera_alt_outlined, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
