import 'package:helpy_app/model/categories_model.dart';
import 'package:helpy_app/modules/Special_screen/special_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:flutter/material.dart';
class DesignCategory extends StatelessWidget {
  final Categories cat;
  String imgurl=base_api;
   DesignCategory(this.cat);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: GestureDetector(
        onTap: (){
          navigateTo(context, SpecialList(cat.title));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.15,
                    width: MediaQuery.of(context).size.width*.40,
                    child: FadeInImage(
                      placeholder:const AssetImage("assets/logo.png"),
                      image: NetworkImage(imgurl+cat.catImg.url!),fit: BoxFit.cover,
                    ),
                  ),
                 const SizedBox(height: 10,),
                  Text(cat.title,
                    style:const TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
