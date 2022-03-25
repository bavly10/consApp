import 'package:flutter/material.dart';
import 'package:helpy_app/model/categories_model.dart';
import 'package:helpy_app/modules/Special_screen/special_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomCatogriesStack extends StatelessWidget {
  final Categories category;
  final String imgurl = base_api;
  const CustomCatogriesStack({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, SpecialList(category.title));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .17,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: NetworkImage(
                    base_api + category.catImg.url!,
                  ),
                ),
              ),
            ),
            Text(
              category.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
