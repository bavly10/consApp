import 'dart:math';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/modules/otp/otp_code.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/shared/my_colors.dart';

class OtpRegister extends StatelessWidget {
  final bool isUSer;
   OtpRegister(this.isUSer);
  final GlobalKey<FormState> _form = GlobalKey();
 late double code;
  var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsCubit,cons_States>(
      listener: (ctx,state){
        if(state is cons_SendTOP_Scusess)
          {
            navigateTo(context, OtpCode(code.toInt(),emailController.text,isUSer));
          }
        else if (state is cons_SendTOP_Error){
          myToast(message: "Something Error Please Try again Later");
        }
      },
     builder: (ctx,state){
       return SafeArea(
         child: Scaffold(
           backgroundColor: Colors.white,
           appBar: AppBar(title: Text(mytranslate(context,"otpemail"),style: TextStyle(color: myAmber),),),
           body: Form(
             key: _form,
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 18),
                     child: Column(
                       children: [
                          Image(image:const ExactAssetImage("assets/email.png"),height: MediaQuery.of(context).size.height*.30,width: double.infinity,),
                         Text(mytranslate(context, "otpRegister1"),style:const TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
                         const  SizedBox(height: 30,),
                         Container(
                           margin:const EdgeInsets.symmetric(horizontal: 2),
                           child: Text(mytranslate(context, "otpRegister2"),style:const TextStyle(color: Colors.black,height: 1.4,fontSize: 16),),
                         ),
                         const  SizedBox(height: 45,),
                         My_TextFormFiled(
                           autofocus: true,
                             validator: (value) => value!.isEmpty ? 'Email is required' :validateEmail(value),
                             controller: emailController,
                             myhintText: mytranslate(context, "email")),
                         const SizedBox(height: 10,),
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(bottom: 8.0),
                     child: Mybutton(context: context,color: myAmber,
                         title:state is cons_SendTOP_Loading
                             ?const SpinKitCircle(color: Colors.white,)
                             :Text( mytranslate(context, "verify"),style:const TextStyle(color: Colors.white),),
                         onPress: (){
                       if (_form.currentState!.validate()){
                         FocusScope.of(context).unfocus();
                         randomCode();
                         ConsCubit.get(context).sendOTPMail(email: emailController.text,code: code.toInt(),);
                       }
                     }),
                   ),
                 ],
               ),
             ),
           ),
         ),
       );
     },
    );
  }
  void randomCode(){
    var rng =Random();
    code = rng.nextDouble() * 10000;
    while (code < 1000) {
      code *= 10;
    }
    print(code.toInt());
  }

}
