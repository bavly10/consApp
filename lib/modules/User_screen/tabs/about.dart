import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/model/user_model.dart';

class AboutIntro extends StatelessWidget {
  final UserStrapi cubit;
  // ignore: use_key_in_widget_constructors
  const AboutIntro(this.cubit);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cons_Cubit,cons_States>(
   builder: (ctx,state){
     return  Padding(
       padding: const EdgeInsets.all(8.0),
       child: Text(cubit.about??"Not Found", style:const TextStyle(fontSize: 18,),textDirection: cons_Cubit.xtranslate?TextDirection.rtl:TextDirection.ltr,),
     );
   },
    );
  }
}
