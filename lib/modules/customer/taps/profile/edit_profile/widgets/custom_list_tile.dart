import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomListTile extends StatelessWidget {
  String textTitle;
  IconData trailingIcon;
  void Function()? onTap;
  CustomListTile(
      {Key? key,
      required this.textTitle,
      required this.trailingIcon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mytranslate(context, textTitle),
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
      ),
      trailing: Icon(
        trailingIcon,
        size: 22,
        color: HexColor('#C18F3A'),
      ),
      onTap: onTap,
    );
  }
}
