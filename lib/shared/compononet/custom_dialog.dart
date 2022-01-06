import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextFieldDialog extends StatelessWidget {
  CustomTextFieldDialog(
      {Key? key,
      required this.controller,
      required this.title,
      required this.buttonText,
      required this.onPressed,
      required this.hintText})
      : super(key: key);

  String title;
  TextEditingController controller;
  String buttonText;
  void Function()? onPressed;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        mytranslate(
          context,
          title,
        ),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: mytranslate(context, hintText),
        ),
      ),
      actions: <Widget>[
        Center(
          child: Container(
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.00),
              color: HexColor('#C18F3A'),
            ),
            child: MaterialButton(
              // color: Colors.white,
              child: Text(
                  mytranslate(
                    context,
                    buttonText,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: onPressed,
            ),
          ),
        )
      ],
    );
  }
}
