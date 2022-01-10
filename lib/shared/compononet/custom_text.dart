import 'dart:ui';

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  late final String text;
  final int? maxLine;
  late final double fontsize;
  final Color? color;
  final double? height;
  late final bool isBold;

  late final Alignment alignment;

  CustomText({
    this.color,
    this.maxLine,
    required this.text,
    required this.fontsize,
    this.isBold=false,
    this.alignment=Alignment.topLeft,
    this.height=1,

  }
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        "$text",style:(TextStyle(
        color: color,

        height:height,
        fontSize: fontsize,fontWeight: isBold?FontWeight.bold:FontWeight.normal,
      )),
        maxLines: maxLine,

      ),

    );
  }
}


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 2.0,
    color: Colors.grey[300],
  ),
);
