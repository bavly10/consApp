import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helpy_app/shared/compononet/custom_text.dart';

class UserRateScreen extends StatelessWidget {
  const UserRateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: 'تقييمات العملاء',alignment: Alignment.center, fontsize: 20,),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child:  ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                     const CircleAvatar(
                        backgroundImage: AssetImage('assets/cust.png'),
                        radius:40,
                      ),
                      const SizedBox(width: 10,),
                      CustomText(text: 'احمد علي ',alignment: Alignment.center, fontsize: 20,),
                     const Spacer(),
                      RatingBar.builder(maxRating: 1,itemBuilder: (context,index)=>const Icon(Icons.star,color: Colors.amber,),
                        onRatingUpdate: (rating){},itemSize: 30,)
                    ],
                  ),
                ),
               const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة  لقد تم توليد هذا النص من مولد النص العربى حيث يمكن هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة  لقد تم توليد هذا النص من مولد النص العربى حيث يمكنك",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle
                      (
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),
                ),
              ],
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
