import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/shared/compononet/builedAdsItem.dart';

class AdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cons_Cubit, cons_States>(builder: (context, state) {
      final listAsd = cons_Cubit.get(context).myads;
      return SingleChildScrollView(
        child: ListView.separated(
          itemBuilder: (context, index) =>
              BuildAdsItem(listAsd[index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 8.0,
          ),
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics(),
          itemCount: listAsd.length,
        ),
      );
    });
  }
}
