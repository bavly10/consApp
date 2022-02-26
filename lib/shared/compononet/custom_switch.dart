import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';

class CustomSwitch extends StatelessWidget {
  final String label;

  final bool selected;
  final Function onChange;

  const CustomSwitch(
      {Key? key,
      required this.label,
      required this.selected,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //1. First widget in row is for label
        //Expanded widget claims the empty area
        Expanded(
          child: RichText(
              text: TextSpan(
                  text: label,
                  style: const TextStyle(fontSize: 17.0, color: Colors.blueGrey),
                  recognizer: TapGestureRecognizer()
                    ..onTap = (){})),
        ),
        //2. Next comes the switch to save the user's selection
        Switch(
          value:UserCubit.get(context).isChecked,
          onChanged: (bool v) {
            onChange(v);
          },
        )
      ],
    );
  }
}
