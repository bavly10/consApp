import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helpy_app/Cubit/my_observer.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/User/post/add_post.dart';
import 'package:helpy_app/modules/User/profile/profile_main.dart';
import 'package:helpy_app/modules/customer/Chat/chats_screen.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/Splash_screen/animation_Splash/main.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';

import 'package:helpy_app/shared/localization/set_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:helpy_app/shared/strings.dart';


import 'modules/Deatils_Special/cubit/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
    await Firebase.initializeApp();
  await CashHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>cons_Cubit()..checkInternetConnectivity()..getCategories()..getSpecailsts()),
        BlocProvider(create: (context)=>ConsCubitIntro()),
        BlocProvider(create: (context)=>CustomerCubit()),
        BlocProvider(create: (context)=>UserCubit()),
      ],
      child: BlocBuilder<cons_Cubit,cons_States>(
        builder: (context,state){
          final cubit=cons_Cubit.get(context);
          return MaterialApp(
            locale: cubit.locale_cubit,
              localizationsDelegates: const [
                SetLocalztion.localizationsDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback:(deviceLocal,supportedLocales){
                for (var local in supportedLocales){
                  if (local.languageCode==deviceLocal!.languageCode && local.countryCode==deviceLocal.countryCode){
                    return deviceLocal;
                  }
                }
                return supportedLocales.first;
              },
              supportedLocales: const [
                Locale('en', 'US'), // English, no country code
                Locale('ar', 'SA'), // Spanish, no country code
              ],
              title: 'Consultation',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(color: myAmber,fontSize: 22,fontWeight: FontWeight.w600),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness:Brightness.dark,
                        statusBarBrightness:Brightness.dark
                    ),
                  iconTheme: IconThemeData(color: myAmber)
                ),
                scaffoldBackgroundColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primarySwatch:Colors.amber,
              ),
            themeMode: ThemeMode.light,
              home: CustomerProfileScreen(),
            builder:EasyLoading.init(),
          );
        },
      ),
    );
  }

}
