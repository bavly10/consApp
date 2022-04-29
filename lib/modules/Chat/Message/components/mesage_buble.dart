import 'package:flutter/material.dart';

class mesagebuble extends StatelessWidget {
  mesagebuble(this.mesage, this.username, this.useriamg, this.isme);

  final String mesage, username, useriamg;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: !isme ? Colors.black : Colors.lightBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft:
                        !isme ? Radius.circular(0) : Radius.circular(14),
                    bottomRight:
                        isme ? Radius.circular(0) : Radius.circular(14),
                  )),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    mesage,
                    style: TextStyle(
                        color: !isme ? Colors.black : Colors.white,
                        fontSize: 17),
                    textAlign: !isme ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(useriamg),
            radius: 25,
          ),
          top: -10,
          right: isme?120:null,
          left: !isme?120:null,
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
