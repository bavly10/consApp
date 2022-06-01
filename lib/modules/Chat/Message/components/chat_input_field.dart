import 'dart:io';

//import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/Message/components/ripple_mic.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:helpy_app/shared/my_colors.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// Import package
import 'package:record/record.dart';

class ChatInputField extends StatelessWidget {
  final String userid, username, custid;
  final ScrollController listController;

  TextEditingController controller = TextEditingController();
  ChatInputField(
      {Key? key,
      required this.custid,
      required this.userid,
      required this.username,
      required this.listController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ConsCubit.get(context).getMyShared();

    return BlocBuilder<ConsChat, ConsChatStates>(
      builder: (ctx, state) {
        final cubit = ConsChat.get(context);
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 6,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 32,
                color: const Color(0xFF087949).withOpacity(0.08),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                cubit.isopen
                    ? IconButton(
                        icon: const Icon(Icons.send, color: kPrimaryColor),
                        onPressed: () {
                          cubit.message!.trim().isEmpty
                              ? null
                              : cubit
                                  .sendMessage(
                                      custid: custid,
                                      context: context,
                                      userid: userid,
                                      username: username)
                                  .then((value) => {
                                        controller.clear(),
                                        FocusScope.of(context).unfocus(),
                                        cubit.isopen = false,
                                      });
                        })
                    : LongPressDraggable(
                        feedback: const Icon(Icons.mic, color: kPrimaryColor),
                        child: cubit.isRecording
                            ? const RipplesMicAnimation()
                            : const Icon(Icons.mic, color: kPrimaryColor),
                        onDragStarted: () async {
                          cubit.isRecording = true;
                          print(cubit.isRecording);
                          ConsChat.get(context).startRecording(context);

                          print(cubit.isRecording);
                          cubit.timerStream =
                              ConsChat.get(context).stopWatchStream();
                          cubit.timerSubscription =
                              cubit.timerStream.listen((int newTick) {
                            cubit.changeTime(newTick);
                            ConsChat.get(context).onWatchChange(newTick);
                          });

                          // Start recording
                        },
                        onDragEnd: (a) async {
                          // if (a.offset.dx < 3000 - 10 / 5) {
                          cubit.StopRecord();
                          cubit.changeStopTimer();

                          cubit.uploadAudio(
                            context: context,
                            custid: custid,
                            userid: userid,
                            username: username,
                          );
                          // }
                        },
                      ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: cubit.isRecording
                        ? Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Recording Now ...${cubit.minutesStr}:${cubit.secondsStr}",
                                  style: TextStyle(
                                      color: myAmber,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ))
                        : Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    listController.animateTo(
                                      0.0,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 500),
                                    );
                                  },
                                  controller: controller,
                                  onChanged: (s) {
                                    if (ConsCubit.get(context).customerID ==
                                        custid) {
                                      cubit.changeIcon(s, userid);
                                    } else {
                                      cubit.changeIcon(s, userid);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        mytranslate(context, "typemessage"),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.attach_file,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(0.64),
                              ),
                              const SizedBox(width: kDefaultPadding / 4),
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(0.64),
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
