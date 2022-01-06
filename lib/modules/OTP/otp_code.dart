import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/User/login/screren/register.dart';
import 'package:helpy_app/modules/customer/login_customer/register.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class OtpCode extends StatelessWidget {
final int mycode;
final String email;
final bool isUser;
  // ignore: use_key_in_widget_constructors
  const OtpCode(this.mycode,this.email,this.isUser);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Verify Your Email Number",style: TextStyle(color: myAmber,fontSize: 24,fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              Container(
                margin:const EdgeInsets.symmetric(horizontal: 2),
                child: RichText(
                  text:TextSpan(
                    text: "Enter Your 4 digit code numbers sent to ",style:const TextStyle(color: Colors.black,height: 1.4,fontSize: 18),
                    children: [
                      TextSpan(
                     text: email,style: TextStyle(color:myAmber)
                    )
                    ]
                  ),

                ),
              ),
              const SizedBox(height: 45,),
              pincodes(context),
              const SizedBox(height: 45,),
               Text(mytranslate(context, "otpcode")),
              TextButton(onPressed: (){
                FocusScope.of(context).unfocus();
                cons_Cubit.get(context).sendOTPMail(email: email,code: mycode,).then((value) =>
                    myToast(message: "Code Has Been sent to $email"));
              }, child: Text(mytranslate(context, "otpcode2"),style: TextStyle(color: myAmber,decoration: TextDecoration.underline,),),),
            ],
          ),
        ),
      ),
    );
  }

  Widget pincodes(BuildContext context){
    return Container(
      width: 250,
      child: PinCodeTextField(
        onChanged: (val){
        },
        appContext: context,
        length: 4,
        autoFocus: true,
        keyboardType: TextInputType.number,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          borderWidth: 1,
          activeColor: myAmber,
          selectedColor: myAmber,
          selectedFillColor: Colors.white,
          inactiveColor: myAmber,
          inactiveFillColor:Colors.white,
        ),
        animationDuration:const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          print(mycode.toString());
          print(code);
          if(code==mycode.toString())
            {
              navigateToFinish(context, isUser? RegisterCustomer(email):Register_intro(email));
            }else{
            myToast(message: "Invalid Code");
          }
          print("Completed");
        },
      ),
    );
  }
}
