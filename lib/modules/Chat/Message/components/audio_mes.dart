import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../shared/my_colors.dart';
import 'package:music_visualizer/music_visualizer.dart';

class AudioMes extends StatelessWidget {
  final DocumentSnapshot document;
  int? index, length;
  var isme;
  AudioMes(
      {Key? key, required this.document, this.isme, this.index, this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      myAmber,
      Colors.white,
      Colors.blueGrey[400]!,
      Colors.brown[900]!
    ];
    final List<Color> colors1 = [
      Colors.red,
      Colors.white,
      Colors.blueGrey[400]!,
      Colors.brown[900]!
    ];
    final List<int> duration = [950, 750, 650, 850, 550];
    Timestamp firebaseTimestamp = document['date'];
    var datee = firebaseTimestamp.toDate();
    var formattedData = intl.DateFormat('h:mm a').format(datee);
    return BlocConsumer<ConsChat, ConsChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                          backgroundImage: NetworkImage(document.get('image')),
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
                              maxWidth: 300,
                              minHeight: 20.0,
                              maxHeight: 170.0,
                            ),
                            child: Wrap(
                              //spacing: 0.0,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              alignment: WrapAlignment.end,
                              children: [
                                ConsChat.get(context)
                                            .audioSelectedList[index!] &&
                                        !ConsChat.get(context).isRecording
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15.0,
                                        ),
                                        child: SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator(
                                            color: isme
                                                ? Colors.blueGrey
                                                : myAmber,
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        color: isme ? Colors.blueGrey : myAmber,
                                        onPressed: () {
                                          print(ConsChat.get(context)
                                              .isRecording);
                                          ConsChat.get(context)
                                              .labelTimer(index);

                                          ConsChat.get(context).selected(
                                              index,
                                              length,
                                              document.data(),
                                              context,
                                              document['vurl']);
                                        },
                                        icon: Icon(
                                          Icons.play_arrow_rounded,
                                          color:
                                              isme ? Colors.blueGrey : myAmber,
                                        ),
                                      ),
                                if (ConsChat.get(context)
                                    .audioSelectedList[index!])
                                  IconButton(
                                    icon: const Icon(Icons.stop_circle),
                                    color: isme ? Colors.blueGrey : myAmber,
                                    onPressed: () {
                                      ConsChat.get(context)
                                          .stopPlay(document['vurl']);
                                    },
                                  ),
                                if (ConsChat.get(context)
                                    .audioSelectedList[index!])
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minHeight: 5,
                                        maxHeight: 30,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                .33,
                                      ),
                                      child: MusicVisualizer(
                                        curve: Curves.bounceInOut,
                                        barCount: 30,
                                        colors: isme ? colors1 : colors,
                                        duration: duration,
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (ConsChat.get(context)
                                        .audioSelectedList[index!] ==
                                    true)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      ConsChat.get(context)
                                          .currentpostlabell[index!],
                                      style: TextStyle(
                                          color: isme
                                              ? Colors.white
                                              : Colors.blueGrey),
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
                                        fontSize: 11,
                                        color:
                                            isme ? Colors.white : Colors.black),
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
