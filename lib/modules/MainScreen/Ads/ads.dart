import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/modules/MainScreen/Ads/ads_Deatils.dart';

import 'package:helpy_app/shared/compononet/custom_ads_card.dart';
import 'package:helpy_app/shared/componotents.dart';


class AdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listAsd = ConsCubit.get(context).myads;
    var listAsd2 = ConsCubit.get(context).myads2;
    final _scrollController = FixedExtentScrollController();
    return BlocConsumer<ConsCubit, cons_States>(
      listener: (context, state) {
        if (state is Cons_noNewData_Ads) {
          myToast(message: "no data");
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => await ConsCubit.get(context).getAds(),
          child: Column(
            children: [
              Expanded(
                child: ClickableListWheelScrollView(
                  scrollController: _scrollController,
                  itemHeight:  250.0,
                  itemCount: listAsd.length,
                  onItemTapCallback: (index)=>navigateTo(context, AdsDetails(listAsd[index].URLLink.toString())),
                  child: ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    physics: const FixedExtentScrollPhysics(),
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .40,
                width: MediaQuery.of(context).size.width,
                child: GridView.custom(
                  //  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return CustomAdsCard(ads: listAsd2[index]);
                    },
                    childCount: listAsd2.length,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}