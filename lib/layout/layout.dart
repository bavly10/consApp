import 'package:flutter/material.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';

Widget myRadioButton(BuildContext context,String title,bool value)=> Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children:   [
      Radio(
      value: value,
      groupValue: UserCubit.get(context).type,
      onChanged: (val){
        FocusScope.of(context).unfocus();
        UserCubit.get(context).changeType(val);
      }),
    const SizedBox(width: 2,),
    Text(title),
    ],
);


