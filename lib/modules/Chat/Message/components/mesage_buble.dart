import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:intl/intl.dart' as intl;

class mesagebuble extends StatelessWidget {
  mesagebuble(
      {required this.mesage,
        required this.username,
        required this.useriamg,
        required this.isme,
        required this.isopen,
        required this.date,
        required this.read});

  final String mesage, username, useriamg,read;
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
                      minWidth: 50.0,
                      maxWidth: 190,
                      minHeight: 30.0,
                      maxHeight: 250.0,
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      alignment: WrapAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            mesage,
                            textWidthBasis: TextWidthBasis.longestLine,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            maxLines: 5,
                            style: TextStyle(
                              height: 1,
                              wordSpacing: 1,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: isme ? Colors.white : Colors.blueGrey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight:5,
                            maxHeight:14,
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
                  decoration:  BoxDecoration(
                    color: read.contains("true")?Colors.orange:Colors.grey,
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
      ),
    );
  }
}