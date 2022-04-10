import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:image_picker/image_picker.dart';

import '../modules/MainScreen/main_screen.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateToFinish(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

My_TextFormFiled({
  bool autofocus = false,
  TextStyle? style,
  required TextEditingController controller,
  IconData? icon,
  Widget? iconsuffix,
  String? lable,
  bool obscureText = false,
  required String? Function(String? val)? validator,
  int? maxLines,
  String? myhintText,
  IconData? myIcons,
  TextDirection? textdirection,
  TextInputAction? textInputAction,
  TextInputType? textInputType,
  IconData? suffix,
  void Function()? suffixPressed,
}) =>
    TextFormField(
      autofocus: autofocus,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      textDirection: textdirection,
      maxLines: maxLines,
      validator: validator,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: InputBorder.none,
        labelText: myhintText ?? '',
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

////////
My_PasswordFormFiled({
  bool autofocus = false,
  TextStyle? style,
  required TextEditingController controller,
  IconData? icon,
  Widget? iconsuffix,
  String? lable,
  bool isPassword = false,
  required String? Function(String? val)? validator,
  String? myhintText,
  IconData? myIcons,
  TextDirection? textdirection,
  TextInputAction? textInputAction,
  TextInputType? textInputType,
  IconData? suffix,
  void Function()? suffixPressed,
}) =>
    TextFormField(
      autofocus: autofocus,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      textDirection: textdirection,
      validator: validator,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: InputBorder.none,
        labelText: myhintText ?? '',
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
Mybutton(
        {required BuildContext context,
        required Function onPress,
        required Widget title,
        Color color = Colors.blue}) =>
    Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.00), color: color),
      child: MaterialButton(
          onPressed: () {
            onPress();
          },
          child: title),
    );

class DialogButton extends StatelessWidget {
  Widget? child;
  double? width;
  double height;
  Color? color;
  Color? highlightColor;
  Color? splashColor;
  Gradient? gradient;
  BorderRadius? radius;
  Function? onPressed;
  BoxBorder? border;
  EdgeInsets? padding;
  EdgeInsets? margin;

  /// DialogButton constructor
  DialogButton({
    Key? key,
    this.child,
    this.width,
    this.height = 40.0,
    this.color,
    this.highlightColor,
    this.splashColor,
    this.gradient,
    this.radius,
    this.border,
    this.padding = const EdgeInsets.only(left: 6, right: 6),
    this.margin = const EdgeInsets.all(6),
    this.onPressed,
  }) : super(key: key);

  /// Creates alert buttons based on constructor params
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).accentColor,
          gradient: gradient,
          borderRadius: radius ?? BorderRadius.circular(6),
          border: border ?? Border.all(color: Colors.transparent, width: 0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: highlightColor ?? Theme.of(context).highlightColor,
          splashColor: splashColor ?? Theme.of(context).splashColor,
          onTap: () {
            onPressed!();
          },
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

My_CustomAlertDialog(
    {Color? iconColor,
    required BuildContext context,
    required Function onPress,
    required String pressTitle,
    required Color pressColor,
    required String bigTitle,
    required String content,
    IconData? icon}) {
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
        onTap: () {},
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(
            child: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  _getRowButtons(context) {
    return [
      DialogButton(
        child: Text(
          pressTitle,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: onPress,
        color: pressColor,
      ),
    ];
  }

  var buttonsRowDirection = 1; //ROW DIRECTION
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: _defaultShape(),
          insetPadding: EdgeInsets.all(8),
          elevation: 10,
          titlePadding: const EdgeInsets.all(0.0),
          title: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          size: 90,
                          color: myAmber,
                        ),
                        Text(
                          bigTitle,
                          style: TextStyle(
                              color: myAmber,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          content,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(8),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getRowButtons(context),
          )));
}

// ignore: missing_return
myCustomDialogERror(BuildContext context) {
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
      side: const BorderSide(
        color: Colors.orange,
      ),
    );
  }

  _getRowButtons(context) {
    return [
      DialogButton(
        child: Text(
          mytranslate(context, "confirm"),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => SystemNavigator.pop(),
        color: Colors.red,
      ),
    ];
  }

  var buttonsRowDirection = 1; //ROW DIRECTION
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shape: _defaultShape(),
            insetPadding: EdgeInsets.all(8),
            elevation: 10,
            titlePadding: const EdgeInsets.all(0.0),
            title: Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          image: const DecorationImage(
                            image: ExactAssetImage(
                              "assets/nonet.jpg",
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      mytranslate(context, "Nointernet"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mytranslate(context, "Makesure"),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(8),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getRowButtons(context),
            ));
      });
}

CustomAlertDialogButtons(
    {required BuildContext context,
    required String pdf,
    required images,
    required Function onTapPdf,
    required Function onTapImages,
    required Function onTapDelete}) {
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: myAmber,
      ),
    );
  }

  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            shape: _defaultShape(),
            insetPadding: EdgeInsets.all(8),
            elevation: 10,
            titlePadding: const EdgeInsets.all(0.0),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(mytranslate(context, "ChoosePicturefrom")),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: myAmber,
                  )
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(8),
            content: Row(
              children: [
                DialogButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        pdf,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  onPressed: onTapPdf,
                  color: myAmber,
                ),
                DialogButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.image_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        images,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  onPressed: onTapImages,
                  color: myAmber,
                ),
                Spacer(),
                DialogButton(
                  child: const Icon(Icons.delete_forever),
                  onPressed: onTapDelete,
                  color: myAmber,
                ),
              ],
            ),
          ));
}

CustomAlertDialog(
    {required Color iconColor,
    required BuildContext context,
    required Function pressText,
    required String pressTitle,
    required Color pressColor,
    required String bigTitle,
    required String content,
    required IconData icon}) {
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.orange,
      ),
    );
  }

  _getRowButtons(context) {
    return [
      DialogButton(
        child: Text(
          pressTitle,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: pressText,
        color: pressColor,
      ),
    ];
  }

  var buttonsRowDirection = 1; //ROW DIRECTION
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          shape: _defaultShape(),
          insetPadding: EdgeInsets.all(8),
          elevation: 10,
          titlePadding: const EdgeInsets.all(0.0),
          title: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          size: 48,
                          color: iconColor,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          bigTitle,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          content,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(8),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getRowButtons(context),
          )));
}

myToast({required String message}) => EasyLoading.showToast(message,
    toastPosition: EasyLoadingToastPosition.bottom,
    duration: const Duration(seconds: 6));

String secureEmail({String? email}) {
  return email!.replaceAll(RegExp(r'(?<=.{2}).(?=.*@)'), '*');
}

String secretEmail(String email) {
  String secretPart = email.substring(2, email.indexOf('@') - 1);
  String star = secretPart.replaceAll(RegExp(r'.'), '*');
  return email.replaceAll(secretPart, star);
}
  void submitData(context) {
    CashHelper.putData('onBoarding', false).then((value) {
      navigateToFinish(context, Mainscreen());
    });
  }
