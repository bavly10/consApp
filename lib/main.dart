import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helpy_app/Cubit/my_observer.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/Splash_screen/animation_Splash/main.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/modules/User/login/screren/register.dart';
import 'package:helpy_app/modules/complian/complian_screen.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';

import 'package:helpy_app/shared/localization/set_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'modules/Deatils_Special/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CashHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserStrapi? cubit;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ConsCubit()
              ..checkInternetConnectivity()
              ..getCategories()
              ..getSpecailsts()
              ..getAds()..getMyShared()),
        BlocProvider(create: (context) => ConsCubitIntro()),
        BlocProvider(
            create: (context) => CustomerCubit()
              ..getCustomerData(ConsCubit.get(context).customerID)),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ConsChat()),
      ],
      child: BlocBuilder<ConsCubit, cons_States>(
        builder: (context, state) {
          final cubit = ConsCubit.get(context);
          return MaterialApp(
            locale: cubit.locale_cubit,
            localizationsDelegates: const [
              SetLocalztion.localizationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var local in supportedLocales) {
                if (local.languageCode == deviceLocal!.languageCode &&
                    local.countryCode == deviceLocal.countryCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.single;
            },
            supportedLocales: const [
              Locale('en', 'US'), // English, no country code
              Locale('ar', 'SA'), // Spanish, no country code
            ],
            title: "Surely",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Cairo',
              appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: myAmber,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.dark),
                  iconTheme: IconThemeData(color: myAmber)),
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: Colors.amber,
            ),
            themeMode: ThemeMode.light,
            home: Animation_Splash(),

            //// HomeServices(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
