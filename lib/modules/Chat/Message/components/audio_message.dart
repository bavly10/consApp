import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/model/ChatMessage.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:intl/intl.dart' as intl;

class AudioMessage extends StatelessWidget {
  // final ChatMessage? message;

  AudioMessage(
      {Key? key,
      required this.mesage,
      required this.username,
      required this.useriamg,
      required this.isme,
      required this.isopen,
      required this.date,
      required this.viewd})
      : super(key: key);
  final String mesage, username, useriamg;
  final bool isme, isopen, viewd;
  Timestamp date;
  @override
  Widget build(BuildContext context) {
    Timestamp firebaseTimestamp = date;
    var datee = firebaseTimestamp.toDate();
    var formattedData = intl.DateFormat('h:mm a').format(datee);
    return BlocBuilder<ConsChat, ConsChatStates>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.only(
              bottom: kDefaultPadding, top: kDefaultPadding),
          child: Column(
            crossAxisAlignment:
                isme ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment:
                    isme ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  if (isme) ...[
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(useriamg),
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                  ],
                  Flexible(
                    child: Container(
                      //  width: 100,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 0.90,
                        vertical: kDefaultPadding / 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          topRight: const Radius.circular(10),
                          bottomLeft: isme
                              ? const Radius.circular(0)
                              : const Radius.circular(10),
                          bottomRight: !isme
                              ? const Radius.circular(0)
                              : const Radius.circular(10),
                        ),
                        color: isme ? myAmber : Colors.grey[300],
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 100.0,
                          maxWidth: 190,
                          minHeight: 20.0,
                          maxHeight: 150.0,
                        ),
                        child: Wrap(
                          //spacing: 0.0,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          alignment: WrapAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  ConsChat.get(context).loadFile(context);
                                },
                                icon: ConsChat.get(context).isPlaying
                                    ? Icon(
                                        Icons.play_arrow,
                                        color: myAmber,
                                      )
                                    : Icon(
                                        Icons.pause,
                                        color: myAmber,
                                      )),
                            SizedBox(
                              /// height: 20,
                              width: MediaQuery.of(context).size.width * .25,
                              child: Slider(
                                activeColor: Colors.blueGrey,
                                autofocus: true,
                                thumbColor: myAmber,
                                value: double.parse(ConsChat.get(context)
                                    .currentpos
                                    .toString()),
                                min: 0.0,
                                max: double.parse(ConsChat.get(context)
                                    .maxduration
                                    .toString()),
                                divisions: ConsChat.get(context).maxduration,
                                label: ConsChat.get(context).currentpostlabel,
                                onChanged: (double value) async {
                                  ConsChat.get(context).labelTimer();
                                  ConsChat.get(context).seekval = value.round();
                                  ConsChat.get(context).result =
                                      await ConsChat.get(context)
                                          .audioPlayer!
                                          .seek(Duration(
                                              milliseconds:
                                                  ConsChat.get(context)
                                                      .seekval!));
                                  if (ConsChat.get(context).result == 1) {
                                    //seek successful
                                    ConsChat.get(context).currentpos =
                                        ConsChat.get(context).seekval!;
                                    print(
                                        "seekval${ConsChat.get(context).seekval}");
                                  } else {
                                    print("Seek unsuccessful.");
                                  }
                                },
                              ),
                            ),
                            Text(
                              ConsChat.get(context).currentpostlabel,
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 5,
                                maxHeight: 14,
                              ),
                              child: Text(
                                formattedData,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: isme ? Colors.white : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!isme)
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          top: MediaQuery.of(context).size.height * .04),
                      height: 14,
                      width: 14,
                      decoration: const BoxDecoration(
                        ///is showed hn8yr loon
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.done,
                        size: 8,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ));
    });
  }

  /* Column(
      child
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2.5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor.withOpacity(isme ? 1 : 0.1),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  ConsChat.get(context).loadFile(context);
                  print(ConsChat.get(context).isPlaying);
                },
                onSecondaryTap: () {},
                child: Icon(
                  ConsChat.get(context).isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: isme ? Colors.white : kPrimaryColor,
                ),
              ),
              Text(
                "0.37",
                style:
                    TextStyle(fontSize: 12, color: isme ? Colors.white : null),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 5,
            maxHeight: 14,
          ),
          child: Text(
            formattedData,
            style: TextStyle(
                fontSize: 11, color: isme ? Colors.white : Colors.black),
          ),
        ),
      ],
    );*/
}
