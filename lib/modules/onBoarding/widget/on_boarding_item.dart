import 'package:flutter/material.dart';
import 'package:helpy_app/modules/onBoarding/onBoarding_screen.dart';
import 'package:helpy_app/shared/compononet/custom_clip_slider.dart';
import 'package:helpy_app/shared/my_colors.dart';

class onBoardingItem extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  onBoardingItem({Key? key, required this.onBoardingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipPath(
          clipper: TsClip1(),
          child: Container(
            height: MediaQuery.of(context).size.height * .45,
            width: MediaQuery.of(context).size.width,
            child: Image(
              //color: Colors.transparent,
              image: AssetImage(
                onBoardingModel.image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height:MediaQuery.of(context).size.height * 0.10,
        ),
        Text(
          onBoardingModel.title,
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
        SizedBox(
          height: 20,
        ),
        Text(onBoardingModel.body,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
