import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/customer_model.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/MainScreen/main_screen.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/shared/compononet/bootm_navigation_bar.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserMain extends StatelessWidget {
  Widget build(BuildContext context) {
    ConsCubit.get(context).getMyShared();
    UserCubit.get(context).getUserDetails(ConsCubit.get(context).userID);
    return BlocBuilder<UserCubit, cons_login_Register_States>(
      builder: (context, state) {
        final model = UserCubit.get(context).loginModel;
        final cubit = UserCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(mytranslate(context, "welcome",), style: const TextStyle(color: Colors.black, fontSize: 18),),
                    const SizedBox(width: 5,),
                    Text(model?.userClass!.username??model?.userClass!.username??"error", style: TextStyle(color: myAmber),)
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.money_rounded,
                        color: HexColor('#C18F3A'),
                      )),
                  IconButton(
                      onPressed: () {
                        CashHelper.removeData("userToken");
                        CashHelper.removeData("userId");
                        navigateToFinish(context, Mainscreen());
                      },
                      icon: Icon(
                        Icons.logout,
                        color: HexColor('#C18F3A'),
                      )),
                ]),
            body: cubit.screen[cubit.currentindex],
            bottomNavigationBar: MyNavigationBar(
              color: mygrey,
              index: cubit.currentindex,
              onTap: cubit.changeIndex,
              iconData0: MdiIcons.home,
              iconData1: MdiIcons.chat,
              iconData2: MdiIcons.paletteAdvanced,
              iconData3: MdiIcons.cog,
            ),
          ),
        );
      },
    );
  }
}
