import 'package:flutter/material.dart';
import 'package:helpy_app/model/categories_model.dart';
import 'package:helpy_app/modules/Special_screen/special_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomCard extends StatelessWidget {
  final Categories cat;
  String imgurl = base_api;
  CustomCard({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, SpecialList(cat.title));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: FadeInImage(
                height:MediaQuery.of(context).size.height*0.15,
                placeholder: const AssetImage("assets/logo.png"),
                image: NetworkImage(imgurl + cat.catImg.url!),
                fit: BoxFit.cover,
              ),
            ),
           const SizedBox(height: 10,),
            Text(cat.title, style: TextStyle(color: HexColor('#C18F3A'),fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
