import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/Chat/Message/components/message.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../shared/compononet/read_more.dart';

class mesagebuble extends StatelessWidget {
  mesagebuble(
      {required this.mesage,
      required this.username,
      required this.useriamg,
      required this.isme,
      required this.isopen,
      required this.date});

  final String mesage, username, useriamg;
  final bool isme, isopen;
  Timestamp date;
  @override
  Widget build(BuildContext context) {
    Timestamp firebaseTimestamp = date;
    var datee = firebaseTimestamp.toDate();
    var formattedData = intl.DateFormat('h:mm a').format(datee);
    return Padding(
      padding:
          const EdgeInsets.only(bottom: kDefaultPadding, top: kDefaultPadding),
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
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: isme
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                      bottomRight: !isme
                          ? const Radius.circular(0)
                          : Radius.circular(10),
                    ),
                    color: isme ? myAmber : Colors.grey[300],
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 50.0,
                      maxWidth: 190,
                      minHeight: 30.0,
                      maxHeight: 250.0,
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      textDirection:
                          isme ? TextDirection.rtl : TextDirection.ltr,
                      //  crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: ExpandableText(mesage,
                              textColor: isme
                                  ? Colors.white
                                  : Colors
                                      .blueGrey), /*Text(
                            mesage,
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: true),
                            textWidthBasis: TextWidthBasis.longestLine,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 5,
                            style: TextStyle(
                              height: 1,
                              wordSpacing: 1,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: isme ? Colors.white : Colors.blueGrey,
                            ),
                          ),*/
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          formattedData,
                          style: TextStyle(
                              fontSize: 13,
                              color: isme ? Colors.white : Colors.black),
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
          if (isopen) ...[
            if (isme)
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(useriamg),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75,
                      vertical: kDefaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(isme ? 1 : 0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "$username Typing...",
                      style: TextStyle(
                        color: isme
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
