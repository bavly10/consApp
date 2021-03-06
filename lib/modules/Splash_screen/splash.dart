import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/MainScreen/main_screen.dart';
import 'package:helpy_app/modules/User/main.dart';
import 'package:helpy_app/modules/customer/main.dart';
import 'package:helpy_app/modules/onBoarding/onBoarding_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => {
              if (CashHelper.getData('onBoarding') == null)
                {
                  navigateToFinish(
                    context,
                    OnBoardingScreen(),
                  )
                }
              else if (ConsCubit.get(context).customerToken == null &&
                  ConsCubit.get(context).userToken == null)
                {navigateToFinish(context, Mainscreen())}
              else if (ConsCubit.get(context).customerToken != null)
                {
                  navigateToFinish(
                    context,
                    MainCustomer(),
                  )
                }
              else
                {
                  navigateToFinish(
                    context,
                    UserMain(),
                  )
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myAmber,
      body: Center(
        child: Image(
          height: MediaQuery.of(context).size.height * 0.20,
          width: double.infinity,
          image: const ExactAssetImage("assets/logo.png"),
        ),
      ),
    );
  }
}
