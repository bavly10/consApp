import 'package:helpy_app/shared/componotents.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/shared/my_colors.dart';

import 'localization/translate.dart';

 myErrorDialog({Color? iconColor, required BuildContext context, String? pressTitle, Color? pressColor, String? bigTitle, String? content, IconData? icon}){
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.orange,
      ),
    );
  }
  _getCloseButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: GestureDetector(
        onTap: () {
        },
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(child:const Icon(Icons.clear,color: Colors.red,),
            onTap: (){
              Navigator.pop(context);
            },),
        ),
      ),
    );
  }
  _getRowButtons(context) {
    return  [
      DialogButton(
        child: Text(
          pressTitle??'',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color:  pressColor,),
    ];

  }
  var buttonsRowDirection=1 ;//ROW DIRECTION
  showDialog(context: context, builder: (ctx)=>AlertDialog(
      backgroundColor:Colors.white,
      shape: _defaultShape(),
      insetPadding: const EdgeInsets.all(8),
      elevation: 10,
      titlePadding: const EdgeInsets.all(0.0),
      title:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getCloseButton(context),
            Padding(
              padding:const EdgeInsets.fromLTRB(
                  20,10, 20, 0),
              child: Column(
                children: [
                  Icon(icon,size: 48,color:iconColor,),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    bigTitle??'',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal),
                    textAlign: TextAlign.center,
                  ),
                  const  SizedBox(
                    height:  10,
                  ),
                  Text(
                    content??'',
                    style:const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height:  20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(8),
      content:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _getRowButtons(context),
      )));
}


String? validateEmail(String value) {
  late String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[gmail,yahoo,cloud]+.com";
  RegExp regex =  RegExp(pattern);
  if (!regex.hasMatch(value) || value.isEmpty) {
    return 'Enter a valid email address';
  }
  return null;
}
String? validateMobile(String value) {
  String pattern = r'(^(?:[+0]966)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);

  if (value.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }

  return null;
}
Widget noPostFound(context){
  return Column(
    children: [
      Image(image:const ExactAssetImage("assets/email.png"),height: MediaQuery.of(context).size.height*.30,width: double.infinity,),
      Text(mytranslate(context, "noData"),style:const TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
    ],
  );
}

Widget noIntroducer(context){
  return Column(
    children: [
      Image(image:const ExactAssetImage("assets/email.png"),height: MediaQuery.of(context).size.height*.30,width: double.infinity,),
      const SizedBox(height: 50,),
      Center(child: Text(mytranslate(context, "noData"),style: TextStyle(color: myAmber,fontSize: 24)))
    ],
  );
}
