import 'package:helpy_app/modules/Splash_screen/animation_Splash/animation_screen.dart';
import 'package:helpy_app/modules/Splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/User/main.dart';
import 'package:helpy_app/modules/customer/main.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:helpy_app/shared/strings.dart';

class Animation_Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
            children: <Widget>[
              if(customerToken==null&&userToken==null) SplashScreen(),
              if (customerToken!=null) MainCustomer(),
              if (userToken!=null) UserMain(),
              IgnorePointer(
                  child: AnimationScreen(color: myAmber)
              )
            ]
        )
    );
  }
}



