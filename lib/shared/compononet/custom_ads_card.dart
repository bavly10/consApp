import 'package:flutter/material.dart';
import 'package:helpy_app/model/ads.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAdsCard extends StatelessWidget {
  final AdsModel ads;
  String imgurl = base_api;
  CustomAdsCard({Key? key, required this.ads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .50,
        decoration: BoxDecoration(
            // gradient: Gradient[Colors.amber,Colors.accents],
            border: Border.all(color: HexColor('#C18F3A'), width: 5),
            borderRadius: const BorderRadius.all(Radius.circular(20))),

        // elevation: 2,

        // color: HexColor('#C18F3A'),

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
              ads.username,
              style: TextStyle(
                  color: HexColor('#C18F3A'),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
