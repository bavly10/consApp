import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Splash_screen/animation_Splash/animation_screen.dart';
import 'package:helpy_app/modules/Splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/User/main.dart';
import 'package:helpy_app/modules/customer/main.dart';
import 'package:helpy_app/shared/my_colors.dart';

class Animation_Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cons_Cubit.get(context).getMyShared();
    return Material(
        child: Stack(
            children: <Widget>[
              SplashScreen(),
              IgnorePointer(
                  child: AnimationScreen(color: myAmber)
              )
            ]
        )
    );
  }
}



