import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/shared/my_colors.dart';


class MyNavigationBar extends StatelessWidget {
  late int index;
  late Function onTap;
  late Color color;
  late IconData iconData0,iconData1,iconData2;
   MyNavigationBar({Key? key, required this.color,required this.index,required this.onTap,required this.iconData0,required this.iconData1,required this.iconData2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      backgroundColor: color,
      color:myAmber,
      height: 50,
      items:  <Widget>[
        Icon(iconData0, size: 30,color:Colors.white),
        Icon(iconData1, size: 30,color: Colors.white,),
        //Image(image: ExactAssetImage("assets/ad.png"),height: 50,width: 30,),
        Icon(iconData2, size: 30,color: Colors.white,),
      ],
      onTap: (int tap) {
        onTap(tap);
      },
    );
  }
}
