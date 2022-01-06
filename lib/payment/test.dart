import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';
import 'package:helpy_app/payment/payment.dart';
import 'package:helpy_app/shared/componotents.dart';


class test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsCubitIntro,cons_StatesIntro>(
      listener: (ctx,state){
        if(state is Cons_Payment_done)
          {
            navigateTo(context, PaymentsTest(state.url));
          }else  if(state is Cons_Payment_notdone){
          EasyLoading.showToast(state.error,toastPosition: EasyLoadingToastPosition.bottom
              ,duration:const Duration(seconds: 3));
        }
      },
      builder: (ctx,state){
       return Center(
          child: TextButton(
            onPressed: ()async{
              await ConsCubitIntro.get(context).getPay();
            },
            child: Text("Press"),
          ),
        );
      },
    );
  }
}
