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
        })
      : super(key: key);
  final String mesage, username, useriamg;
  final bool isme, isopen;
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
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: isme
                              ? const Radius.circular(0)
                              : const Radius.circular(20),
                          bottomRight: !isme
                              ? const Radius.circular(0)
                              : const Radius.circular(20),
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
                                  ConsChat.get(context).labelTimer();

                                  ConsChat.get(context).changePlayed(context,
                                      ConsChat.get(context).isPlaying, mesage);
                                },
                                icon: ConsChat.get(context).isPlaying
                                    ? Icon(
                                  Icons.pause_circle,
                                  color: isme ? Colors.blueGrey : myAmber,
                                )
                                    : Icon(
                                  Icons.play_arrow_rounded,
                                  color: isme ? Colors.blueGrey : myAmber,
                                )),
                            SizedBox(
                              /// height: 20,
                              width: MediaQuery.of(context).size.width * .25,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor:
                                  isme ? Colors.white : Colors.blueGrey,
                                  inactiveTrackColor:
                                  isme ? Colors.blueGrey : Colors.white,
                                  trackHeight: 3.0,
                                  thumbColor: Colors.yellow,
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 8.0),
                                  overlayColor: Colors.purple.withAlpha(32),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 14.0),
                                ),
                                child: Slider(
                                  autofocus: true,
                                  thumbColor: isme ? Colors.blueGrey : myAmber,
                                  value: double.parse(ConsChat.get(context)
                                      .currentpos
                                      .toString()),
                                  min: 0.0,
                                  max: double.parse(ConsChat.get(context)
                                      .maxduration
                                      .toString()),
                                  // divisions: ConsChat.get(context).duration,
                                  label: ConsChat.get(context).currentpostlabel,
                                  onChanged: (double value) async {
                                    ConsChat.get(context).seekAudio(value);
                                  },
                                ),
                              ),
                            ),
                            Text(
                              ConsChat.get(context).currentpostlabel,
                              style: TextStyle(
                                  color: isme ? Colors.white : Colors.blueGrey),
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
}
