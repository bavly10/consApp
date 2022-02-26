import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomPrivacyDialog extends StatefulWidget {
  CustomPrivacyDialog(
      {Key? key,
      required this.title,
      required this.privacyText,
      required this.buttonText,
      required this.onPressed,
      required this.isChecked,
      required this.onChanged})
      : super(key: key);

  String title;
  String privacyText;
  String buttonText;
  void Function()? onPressed;
  bool isChecked;
  void Function(bool?)? onChanged;

  @override
  State<CustomPrivacyDialog> createState() => _CustomPrivacyDialogState();
}

class _CustomPrivacyDialogState extends State<CustomPrivacyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.privacyText,
            maxLines: 20,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: HexColor('#C18F3A'),
                  value: widget.isChecked,
                  onChanged: (s) {
                    setState(() {
                      widget.onChanged;
                    });
                  },
                ),
                const Text('Accept'),
              ],
            ),
          )
        ],
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
              child: Text(widget.buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
              onPressed: widget.onPressed,
            ),
          ),
        )
      ],
    );
  }
}
