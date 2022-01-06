import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/main.dart';

import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class LoginUser extends StatefulWidget {
  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var emailController=TextEditingController();
  var passController=TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  @override
  void initState() {
    super.initState();
    emailController=TextEditingController();
    passController=TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit,Customer_States>(
      builder: (ctx,state){
        return FadeIn(
          duration:const Duration(seconds: 1),
          curve: Curves.bounceInOut,
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.00),
                  child: My_TextFormFiled(
                    controller: emailController,myhintText: mytranslate(context, "email"),
                    validator: (value) => value!.isEmpty ? 'Email is required' :validateEmail(value),
                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.00),
                  child: My_TextFormFiled(
                    validator:(String? s){if(s!.isEmpty)return  "Password is required";},
                    controller: passController,
                    myhintText:mytranslate(context, "Password"),
                  ),
                ),
                const  SizedBox(height: 15,),
                Center(
                    child: Mybutton(color: myAmber,context: context, onPress: ()async {
                      if(_form.currentState!.validate())
                      {
                        FocusScope.of(context).unfocus();
                        try{
                      await CustomerCubit.get(context).signin(emailController.text, passController.text).then((value) =>{
                        navigateTo(context,  MainCustomer())
                      });
                        }catch(error){
                          var errormsg = "Failed login Please Try again";
                          if (error.toString().contains('INVALID_EMAIL')) {
                            errormsg = "this is not a Valid Email";
                          } else if (error.toString().contains('INVALID_PASSWORD')) {
                            errormsg = "Incorrect Password";
                          } else if (error.toString().contains('WEAK_PASSWORD')) {
                            errormsg = "Password Is to weak";
                          } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
                            errormsg = "This Email is Not Found";
                          }
                         myToast(message: errormsg);
                          print(error.toString());
                        }
                      }
                    }, title: state is LoginLoadingState
                        ? SpinKitCircle(color: myAmber,)
                        : Text(mytranslate(context, "login"), style: const TextStyle(color: Colors.white, fontSize: 18),))
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: (){},child: Text(mytranslate(context, "forgetpass"),style: TextStyle(color: myAmber),),)

              ],
            ),
          ),
        );
      },
    );
  }
}
