import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/shared/componotents.dart';
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
        style:const TextStyle(
          fontSize: 14,
        ),
      ),
      content: My_PasswordFormFiled(
        suffix: cons_Cubit.get(context).iconVisiblity,
        suffixPressed: () {
          cons_Cubit.get(context).changPasswordVisibilty();
        },
        isPassword: cons_Cubit.get(context).isPassword,
        controller: controller,
        myhintText: mytranslate(context, hintText),
        validator: (String? s) {
          if (s!.isEmpty) return "Password is required";
        },
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
                  style:const TextStyle(
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
