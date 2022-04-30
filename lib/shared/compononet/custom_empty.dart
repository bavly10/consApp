import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class CustomEmpty extends StatelessWidget {
  String? text;
  CustomEmpty({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image(
                image: ExactAssetImage('assets/ch.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          text!,
          style: TextStyle(
              color: myAmber,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ],
    );
  }
}
