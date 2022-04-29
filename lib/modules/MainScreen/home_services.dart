import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/shared/compononet/custom_catogries_stack.dart';
import 'package:helpy_app/shared/my_colors.dart';

class HomeServices extends StatelessWidget {
  const HomeServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsCubit, cons_States>(builder: (context, state) {
      final listCat = ConsCubit.get(context).mycat;
      return listCat.isEmpty
          ? Center(
              child: SpinKitCircle(
                color: myAmber,
              ),
            )
          : ListView.builder(
        physics: const BouncingScrollPhysics(),
              itemCount: listCat.length,
              itemBuilder: (context, index) {
                return CustomCatogriesStack(category: listCat[index]);
              },
            );
    });
  }
}
