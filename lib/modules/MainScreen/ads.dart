import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';

import 'package:helpy_app/shared/compononet/custom_ads_card.dart';
import 'package:helpy_app/shared/compononet/custom_card_mainCustomer.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:helpy_app/shared/localization/translate.dart';

class AdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listAsd = cons_Cubit.get(context).myads;
    return BlocConsumer<cons_Cubit, cons_States>(
      listener: (context, state) {
        if (state is Cons_noNewData_Ads) {
          myToast(message: "no data");
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => await cons_Cubit.get(context).getAds(),
          child: Column(
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 350,
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return CustomAdsCard(
                          ads: listAsd[index],
                        );
                      },
                      childCount: listAsd.length),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * .40,
                  width: MediaQuery.of(context).size.width,
                  child: MasonryGridView.count(
                    itemCount: listAsd.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      return CustomAdsCard(ads: listAsd[index]);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }
}
