import 'package:flutter/material.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/OTP/otp_register.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
//import 'package:helpy_app/modules/login/main_login.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';


class MySlideDialog extends StatelessWidget {
  final User cubit;
  MySlideDialog(this.cubit);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: mytranslate(context, "connect"),
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                  children: [
                TextSpan(
                    text: cubit.username,
                    style: TextStyle(
                        color: myAmber,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  mytranslate(context, "mustLogin"),
                  style: const TextStyle(color: Colors.black, height: 1.4),
                ),
                TextButton(
                    onPressed: () {
                      navigateTo(context, Main_login());
                    },
                    child: Text(
                      mytranslate(context, "login"),
                      style: TextStyle(color: myAmber),
                    ))
              ],
            ),
          ),
          Mybutton(
              context: context,
              onPress: () {
                navigateToFinish(context, OtpRegister(false));
              },
              color: myAmber,
              title: Text(
                mytranslate(context, "Signup"),
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
