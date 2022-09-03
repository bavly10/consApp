import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/Chat/Message/components/zoom_image.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../shared/my_colors.dart';
import 'package:music_visualizer/music_visualizer.dart';

class ImageMessage extends StatelessWidget {
  final DocumentSnapshot document;
  int? index, length;
  var isme;
  ImageMessage(
      {Key? key, required this.document, this.isme, this.index, this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp firebaseTimestamp = document['date'];
    var datee = firebaseTimestamp.toDate();
    var formattedData = intl.DateFormat('h:mm a').format(datee);
    TransformationController controller = TransformationController();
    return BlocConsumer<ConsChat, ConsChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ConsChat.get(context);
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
                      document['imagechat'] == null
                          ? SpinKitCircle(
                              color: myAmber,
                            )
                          : InkWell(
                              onTap: (() => navigateTo(context,
                                  ZoomImage(image: document['imagechat']))),
                              child: Container(
                                //  width: 100,
                                //  padding: const EdgeInsets.symmetric(
                                //  horizontal: kDefaultPadding * 0.90,
                                //  vertical: kDefaultPadding,
                                // ),
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
                                    maxWidth: 200,
                                    minHeight: 30.0,
                                    maxHeight: 200.0,
                                  ),
                                  child: Stack(
                                    //spacing: 0.0,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      InteractiveViewer(
                                          transformationController: controller,
                                          boundaryMargin: EdgeInsets.all(5.0),
                                          onInteractionEnd:
                                              (ScaleEndDetails endDetails) {
                                            print(endDetails);
                                            print(endDetails.velocity);
                                          },
                                          child: Image.network(
                                              document['imagechat'])),
                                      //fit: BoxFit.cover,

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
                                              color: isme
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      // if (!isme)
                      //   Container(
                      //     margin: EdgeInsetsDirectional.only(
                      //         top: MediaQuery.of(context).size.height * .04),
                      //     height: 14,
                      //     width: 14,
                      //     decoration: const BoxDecoration(
                      //       ///is showed hn8yr loon
                      //       color: Colors.grey,
                      //       shape: BoxShape.circle,
                      //     ),
                      //     child: Icon(
                      //       Icons.done,
                      //       size: 8,
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //     ),
                      //   ),
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
