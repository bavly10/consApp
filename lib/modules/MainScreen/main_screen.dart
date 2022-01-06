import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/shared/compononet/design_category.dart';
import 'package:helpy_app/shared/compononet/bootm_navigation_bar.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Mainscreen extends StatefulWidget {
  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cons_Cubit, cons_States>(
      builder: (context, state) {
        final cubit = cons_Cubit.get(context);
        List<String> titles = [
          mytranslate(context, "chose_cat"),
          mytranslate(context, "ads"),
          mytranslate(context, "setting"),
        ];
        return Scaffold(
          bottomNavigationBar:MyNavigationBar(
            color: Colors.white,
            index:cubit.currentindex,
            onTap:cubit.changeIndex,
            iconData0:MdiIcons.home,
            iconData1: Icons.add_comment_sharp,
            iconData2: Icons.settings,
          ),
          appBar: AppBar(
            leading: Icon(MdiIcons.magnify,size: 30,color: myAmber,),
            title: Text(titles[cubit.currentindex],style: TextStyle(color: myAmber),),
          ),
          body:cubit.screen[cubit.currentindex],
        );
      },
    );
  }
}
