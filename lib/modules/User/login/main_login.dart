import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/login/screren/login_user.dart';
import 'package:helpy_app/modules/customer/login_customer/login_customer.dart';

import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main_login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, cons_login_Register_States>(
      builder: (ctx, state) {
        final cubit = UserCubit.get(context);
        return Scaffold(
            body: SingleChildScrollView(
             child: Stack(
               children: [
                 SizedBox(height:MediaQuery.of(context).size.height*1,
                     width: double.infinity,
                     child:const Image(image: ExactAssetImage("assets/ground.png"))),
                 Padding(
                    padding: const EdgeInsets.all(12),
                  child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: double.infinity,
                          image:const ExactAssetImage("assets/logo.png"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              cubit.changeDesigns();
                            },
                            child: cubit.visable
                                ? Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:const BorderRadius.all(Radius.circular(9.0)),
                                        color: myAmber),
                                    child: Center(
                                        child: Text(
                                      mytranslate(context, "buttonLogin2"),
                                      style:const TextStyle(color: Colors.white),
                                    )))
                                : Text(
                                    mytranslate(context, "buttonLogin2"),
                                    style: TextStyle(color: myAmber),
                                  )),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              cubit.changeDesign();
                            },
                            child: cubit.visable
                                ? Text(
                                    mytranslate(context, "buttonLogin1"),
                                    style: TextStyle(color: myAmber),
                                  )
                                : Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const  BorderRadius.all(Radius.circular(9.0)),
                                        color: myAmber),
                                    child: Center(
                                        child: Text(
                                      mytranslate(context, "buttonLogin1"),
                                      style:const TextStyle(color: Colors.white),
                                    )))),
                      ],
                    ),
                    cubit.visable? LoginUser() : LoginIntro(),
                  ],
              ),
            ),
               ],
             ),
        ));
      },
    );
  }
}
