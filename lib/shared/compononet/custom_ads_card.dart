import 'package:flutter/material.dart';
import 'package:helpy_app/model/ads.dart';
import 'package:helpy_app/modules/MainScreen/Ads/ads_Deatils.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAdsCard extends StatelessWidget {
  final Ads ads;
  String imgurl = base_api;
  CustomAdsCard({Key? key, required this.ads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: (){
          navigateTo(context, AdsDetails(ads.URLLink!));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .25,
          decoration: BoxDecoration(
              border: Border.all(color: HexColor('#C18F3A'), width: 5),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInImage(
                height: MediaQuery.of(context).size.height * 0.15,
                placeholder: const AssetImage("assets/logo.png"),
                image: NetworkImage(base_api + ads.profileImage.url!),
                fit: BoxFit.cover,
              ),
              Text(
                ads.Name!,
                style: TextStyle(
                    color: HexColor('#C18F3A'),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
