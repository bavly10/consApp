import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/shared/compononet/custom_clipper.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomClipPath extends StatelessWidget {
  String myText;
  CustomClipPath({Key? key, required this.myText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      child: BlocBuilder<UserCubit, cons_login_Register_States>(
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height * 0.27;
          return ClipPath(
            child: Material(
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: Colors.grey,
              color: Colors.white,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          mytranslate(context, "privacy"),
                          style: TextStyle(
                              color: myAmber, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          myText,
                          maxLines: 22,
                        ),
                      ),
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
                ),
                width: MediaQuery.of(context).size.width * .45,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            clipper: FullTicketClipper(
                15,
                height *
                    2), // Comment this out if you want to replace ClipPath with ClipOval
          );
        },
      ),
    );
  }
}
