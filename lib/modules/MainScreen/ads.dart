import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/shared/compononet/builedAdsItem.dart';
import 'package:helpy_app/shared/componotents.dart';

class AdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listAsd = cons_Cubit.get(context).myads;
    return BlocConsumer<cons_Cubit, cons_States>(
      listener: (context,state){
        if(state is Cons_noNewData_Ads){
          myToast(message: "no data");
        }
      },
      builder: (context,state){
        return RefreshIndicator(
          onRefresh: ()async=>await cons_Cubit.get(context).getAds(),
          child: SafeArea(
            child: Container(
              color: Colors.grey[300],
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    BuildAdsItem(listAsd[index]),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: listAsd.length,
              ),
            ),
          ),
        );
      },
      );
  }
}
