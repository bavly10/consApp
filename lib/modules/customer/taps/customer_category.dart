import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/shared/compononet/design_category.dart';
import 'package:helpy_app/shared/my_colors.dart';

class CustomerCategory extends StatelessWidget {
  const CustomerCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cons_Cubit, cons_States>(
        builder: (ctx,state){
          final listCat=cons_Cubit.get(context).mycat;
          return listCat.isEmpty
              ? Center(child: SpinKitCircle(color: myAmber,),)
              : ListView.separated(
                physics:const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(padding:const EdgeInsetsDirectional.all(4),
                    child: DesignCategory(listCat[index],)),
                itemCount: listCat.length,
                separatorBuilder: (ctx, index) {return Divider(height: 1, color: myAmber,);},
              );
        }
    );
  }
}
