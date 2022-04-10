import 'package:flutter/material.dart';
import 'package:helpy_app/modules/MainScreen/main_screen.dart';
import 'package:helpy_app/modules/onBoarding/widget/on_boarding_item.dart';
import 'package:helpy_app/modules/onBoarding/widget/ripple_button.dart';
import 'package:helpy_app/shared/compononet/custom_clip_slider.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String image;
  String title;
  String body;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

var boardController = PageController();

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  List<OnBoardingModel> onBoardingmodel = [
    OnBoardingModel(
        title: ' خدمات متعددة',
        body: 'احصل على افضل خدمة في بيتك',
        image: 'assets/b2.png'),
    OnBoardingModel(
        title: 'سرعة الاستجابة ',
        body: 'بضغطةزر خدمتك تصلك',
        image: 'assets/b2.png'),
    OnBoardingModel(
        title: 'اسعار مغرية',
        body: 'عيش تجربة فريدةي ',
        image: 'assets/b3.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myAmber,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: PageView.builder(
              onPageChanged: (value) {
                if (value == onBoardingmodel.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemCount: onBoardingmodel.length,
              controller: boardController,
              itemBuilder: (context, index) {
                return onBoardingItem(onBoardingModel: onBoardingmodel[index]);
              }),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SmoothPageIndicator(
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.blueGrey[700]!,
                  spacing: 20,
                  dotColor: Colors.white,
                ),
                controller: boardController,
                count: onBoardingmodel.length,
              ),
              const Spacer(),
              isLast
                  ? const RipplesAnimation()
                  : TextButton(
                      child: Text(
                        mytranslate(context, "getstarted"),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            wordSpacing: 2,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo'),
                      ),
                      onPressed: () {
                        submitData(context);
                      })
            ],
          ),
        ),
      ]),
    );
  }
}
