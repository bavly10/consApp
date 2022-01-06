import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/model/customer_model.dart';
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

class MainCustomer extends StatelessWidget {
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getCustomerData(customerID);
    return BlocBuilder<CustomerCubit, Customer_States>(
        builder: (context,state){
          final cubit = CustomerCubit.get(context);
          final model = CustomerCubit.get(context).model;
          return SafeArea(
            child: Scaffold(
              backgroundColor:mygrey,
              appBar: AppBar(title: Row(
                mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(mytranslate(context, "welcome",),style:const TextStyle(color: Colors.black,fontSize: 18),),
                  const SizedBox(width: 5,),
                Text(model?.username??"Error",style:TextStyle(color: myAmber),)
                ],
              ),
                  actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: HexColor('#C18F3A'),
                  )),
                IconButton(
                  onPressed: () {
                    CashHelper.removeData("cust_token");
                    CashHelper.removeData("cust_id");
                    navigateToFinish(context, Main_login());
                  },
                  icon: Icon(
                    Icons.logout,
                    color: HexColor('#C18F3A'),
                  )),
                  ]),
              body:cubit.screen[cubit.currentindex],
              bottomNavigationBar: MyNavigationBar(
                color: mygrey,
                index: cubit.currentindex,
                onTap: cubit.changeIndex,
                iconData0: MdiIcons.home,
                iconData1: MdiIcons.chat,
                iconData2: MdiIcons.cog,
              ),
            ),
          );
        },
    );
  }
}
