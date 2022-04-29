import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/shared/compononet/custom_card_mainCustomer.dart';
import 'package:helpy_app/shared/my_colors.dart';

class CustomerCategory extends StatelessWidget {
  const CustomerCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsCubit, cons_States>(
        builder: (ctx,state){
          final listCat=ConsCubit.get(context).mycat;
          return listCat.isEmpty
              ? Center(child: SpinKitCircle(color: myAmber,),)
              :GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listCat.length,
            gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 2 / 2,
                maxCrossAxisExtent: 290,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20),
            itemBuilder: (context, index) {
              return CustomCard(cat: listCat[index]);
            },
          );
        }
    );
  }
}
