import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/model/lang.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../MainScreen/main_screen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cons_Cubit, cons_States>(
      builder: (ctx, state) {
        final cubit = cons_Cubit.get(context);
        return Scaffold(
          body: Column(
            children: [
             Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: double.infinity,
                        image: const ExactAssetImage("assets/logo.png"),
                      ),
                      const SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topCenter, child: Text(
                          mytranslate(context, "splash_screen"),
                          style: TextStyle(
                              color: myAmber, fontSize: 25,fontWeight: FontWeight.bold),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topCenter, child: Text(
                          mytranslate(context, "splash_screen2"),
                          style:const TextStyle(fontSize: 22),)),
                      ),
                      const SizedBox(height:55,),
                      Center(child: Mybutton(color: myAmber,
                          context: context,
                          onPress: () {
                            navigateTo(context, Mainscreen());
                          },
                          title: Text(
                            mytranslate(context, "splash_screenButton1"),
                            style:const TextStyle(
                                color: Colors.white, fontSize: 18),))),
                      const SizedBox(height: 25,),
                      Center(child: Mybutton(color: myAmber,
                          context: context,
                          onPress: () async {
                            await cons_Cubit.get(context)
                                .checkInternetConnectivity();
                            if (cubit.isConnected) {
                              navigateTo(context, Main_login());
                            } else {
                              myCustomDialogERror(context);
                            }
                          },
                          title: Text(mytranslate(
                              context, "splash_screenButton2"),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),))),
                    ],
                  ),
                ),
              const Spacer(),
              Padding(padding: const EdgeInsets.all(2), child: DropdownButton(
                onChanged: (lang) {
                  cubit.changeLang(lang, context);
                },
                items: lanugage.lang_list.map<DropdownMenuItem<lanugage>>((
                    lang) =>
                    DropdownMenuItem(
                      value: lang,
                      child: Row(
                        children: [
                          Text(lang.flag!),
                          const SizedBox(width: 10,),
                          Text(lang.name!)
                        ],
                      ),
                    )).toList(),
                underline:const SizedBox(),
                hint: Row(children: [
                  Text(mytranslate(context, "change_lang"),
                    style: TextStyle(color:myAmber, fontSize: 14),),
                  const  SizedBox(width: 5,),
                  Text(mytranslate(context, "changelang"), style:const TextStyle(
                      color: Colors.amber,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),),
                ],),
              ),),
            ],
          ),
        );
      },
    );
  }
}