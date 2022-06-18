// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/post/add_post.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, cons_login_Register_States>(
      listener: (context, state) {},
      builder: (context, state) {
        final model = UserCubit.get(context).loginModel;
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: model?.userClass!.points == null
                        ? 0
                        : model!.userClass!.points!,
                    center: Text(
                      "${model?.userClass!.points == null ? 0 : model!.userClass!.points}",
                      //mytranslate(context, "point"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    footer: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        mytranslate(context, "increas"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: HexColor('#C18F3A'),
                  ),
                ),
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Container(
                      height: MediaQuery.of(context).size.height * .15,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: RichText(
                            text: TextSpan(
                          text: mytranslate(context, "posttext"),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  navigateTo(context, CreatePost());
                                },
                              text: mytranslate(context, "press"),
                              style: TextStyle(
                                  color: HexColor('#C18F3A'),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                      ))),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Card(
                      color: HexColor('#C18F3A'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * .20,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                mytranslate(context, "chat"),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '12',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                    Spacer(),
                    Card(
                      color: HexColor('#F7F7F7'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * .20,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                mytranslate(context, "oldchat"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('4'),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ]));
      },
    );
  }
}
