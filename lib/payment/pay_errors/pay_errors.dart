import 'package:flutter/material.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User_screen/edit_introducer.dart';
import 'package:helpy_app/modules/User_screen/tabs/introducer.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class PaymentError extends StatelessWidget {
  final UserStrapi cubit;
  final dynamic mytext;
  const PaymentError({Key? key, required this.cubit, this.mytext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#eff1f3'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/15_Payment Error.png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.50,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              mytext,
              style: const TextStyle(fontSize: 18.0, color: Colors.blueGrey),
              textAlign: TextAlign.center,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: Color(0xFF5666C2).withOpacity(0.17),
                  ),
                ],
              ),
              child: FlatButton(
                color: HexColor('#C18F3A'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  navigateToFinish(context, Introducer(cubit.id!));
                },
                child: Text(
                  mytranslate(context, "back"),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
