import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomPrivacyDialog extends StatelessWidget {
  final String mytext;

  const CustomPrivacyDialog({Key? key,required this.mytext}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, cons_login_Register_States>(
        builder: (ctx, state){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text( mytranslate(context, "privacy"),
              style:const TextStyle(
                fontSize: 14,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mytext,maxLines: 28,),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: HexColor('#C18F3A'),
                        value: UserCubit.get(context).isChecked,
                        onChanged: (s) {
                          UserCubit.get(context).changeChecked(s!);
                          Navigator.pop(context);
                        },
                      ),
                      const Text('Accept'),
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}