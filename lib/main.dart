import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:helpy_app/Cubit/my_observer.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/Splash_screen/animation_Splash/main.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/shared/compononet/custom_notification_dialog.dart';
import 'package:helpy_app/shared/componotents.dart';

import 'package:helpy_app/shared/localization/set_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'modules/Deatils_Special/cubit/cubit.dart';
import 'modules/User/login/screren/register.dart';
import 'modules/customer/Chat/chats_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data["click_action"] == "FLUTTER_NOTIFICATION_CLICK") {
    navigateTo(
      BuildContext,
      ChatsScreen(),
    );
  }
  print('When app in background:${message.data.toString()}');
}

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CashHelper.init();

  await FirebaseMessaging.instance.getToken().then((value) {
    var tokenFcm = value;
    print(tokenFcm);
  });

  BuildContext dialogContext; //
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print('when open ${event.notification!.body}');

    // myToast(message: "${event.notification!.body}");
    showDialog(
        context: navigatorKey.currentState!.overlay!.context,
        builder: (context) {
          dialogContext = context;
          return CustomNotificationDialog(
            notifiText: event.notification!.body!,
          );
        });
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('when app open in background:${event.data.toString()}');
    if (event.data["click_action"] == "FLUTTER_NOTIFICATION_CLICK") {
      navigateTo(
        BuildContext,
        ChatsScreen(),
      );
      // navigateTo(context, )
    }
  });
  FirebaseMessaging.onBackgroundMessage((firebaseMessagingBackgroundHandler));
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
              ..getAds()
              ..getMyShared()
              ..getLocale()),
        BlocProvider(create: (context) => ConsCubitIntro()),
        BlocProvider(
            create: (context) => CustomerCubit()
              ..getCustomerData(ConsCubit.get(context).customerID)),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ConsChat() //..labelTimer()
            ),
      ],
      child: BlocBuilder<ConsCubit, cons_States>(
        builder: (context, state) {
          final cubit = ConsCubit.get(context);
          return MaterialApp(
            navigatorKey: navigatorKey,
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
              return supportedLocales.first;
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
            // Register_intro('hamza6063@gmail.com'),

            //// HomeServices(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
