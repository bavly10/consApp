import 'package:flutter/material.dart';
import 'package:helpy_app/model/ads.dart';
import 'package:helpy_app/shared/network.dart';

class BuildAdsItem extends StatelessWidget {
  final  AdsModel model;
  // ignore: use_key_in_widget_constructors
  const BuildAdsItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(base_api + model.profileImage.url!),
              radius: 35.0,
            ),
            const  SizedBox(
              width: 10,
            ),
            Text(
              model.username,
              style:const TextStyle(fontSize: 20),
            ),
          ],
        ),
        Text(model.description),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(base_api + model.contentImage.url!),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
      ],
    );
  }
}
