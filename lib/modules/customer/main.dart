import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/model/customer_model.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/shared/compononet/bootm_navigation_bar.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainCustomer extends StatelessWidget {
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getCustomerData(customerID);
    return BlocConsumer<CustomerCubit, Customer_States>(
        listener: (ctx,state){
        },
        builder: (context,state){
          final cubit = CustomerCubit.get(context);
          final model = CustomerCubit.get(context).model;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title: Row(
                mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(mytranslate(context, "welcome",),style:const TextStyle(color: Colors.black,fontSize: 18),),
                  const SizedBox(width: 5,),
                Text(model?.username??"Error",style:const TextStyle(color: Colors.black),)
                ],
              ),),
              body: Stack(children: [
                Container(
                  margin:const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color:mygrey, borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
                  child: cubit.screen[cubit.currentindex],
                ),
              ]),
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
