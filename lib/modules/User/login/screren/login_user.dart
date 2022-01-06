import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/MainScreen/main_screen.dart';
import 'package:helpy_app/modules/otp/otp_register.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class LoginIntro extends StatefulWidget {
  @override
  State<LoginIntro> createState() => _LoginIntroState();
}

class _LoginIntroState extends State<LoginIntro> {
  var emailsController=TextEditingController();
  var passsController=TextEditingController();
   GlobalKey<FormState> formState = GlobalKey();
  bool myState=false;

  @override
  void initState() {
    super.initState();
    emailsController=TextEditingController();
    passsController=TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    emailsController.dispose();
    passsController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,cons_login_Register_States>(
      listener:(ctx,state){
        if(state is cons_Loading_login) {
          myState=true;
        }
        else if (state is cons_Login_Scusess) {
          if (state.loginModel.userClass!.confirmed == true)
          {
            navigateToFinish(context, Mainscreen());
          }
          else {
            My_CustomAlertDialog(
              icon: Icons.warning_rounded,
              bigTitle:mytranslate(context, "dialogRegistertitle"),
              content: mytranslate(context, "gialogLogin"),
              context: context,
              pressColor: myAmber,
              pressTitle:mytranslate(context, "done"),
              pressText: () {
                Navigator.of(context).pop();
              },
            );
          }
          myState=false;
        }
        else if (state is cons_Login_Error) {
          state.loginModel.message!.map((e) => e.messages!.map((e) =>
              My_CustomAlertDialog(
                icon: Icons.warning_rounded,
                bigTitle:mytranslate(context, "dialogRegistertitle"),
                content:e.message.toString(),
                context: context,
                pressColor: myAmber,
                pressTitle:mytranslate(context, "done"),
                pressText: () {
                  Navigator.of(context).pop();
                },
              ))).toString();
          myState=false;
        }
      },
      child:FadeIn(
        duration:const Duration(seconds: 1),
        curve: Curves.easeInCirc,
        child: Form(
          key: formState,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.00),
                child: My_TextFormFiled(controller: emailsController,myhintText: mytranslate(context, "email"),
                  validator:(String? s){if(s!.isEmpty) return  "Email is required";},
                ),

              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.00),
                 child: My_TextFormFiled(controller: passsController,myhintText: mytranslate(context, "Password"),
                validator:(String? s){if(s!.isEmpty) return  "Password is required";},
              ),
              ),
             const SizedBox(height: 15,),
              Center(
                  child: Mybutton(color: myAmber,context: context, onPress: ()async {
                    if(formState.currentState != null &&formState.currentState!.validate())
                    {
                      FocusScope.of(context).unfocus();
                      await UserCubit.get(context).login(emailsController.text, passsController.text);
                    }
                  }, title: myState
                      ? const Center(child:SpinKitCircle(color: Colors.white,))
                      : Text(mytranslate(context, "login"), style: const TextStyle(color: Colors.white, fontSize: 18),))
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${mytranslate(context, "donthave")} - ",
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            color: Colors.black,
                          )),
                      InkWell(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          navigateTo(context, OtpRegister(false));
                        },
                        child:Text(mytranslate(context, "Signup"), style:const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  TextButton(onPressed: (){},child: Text(mytranslate(context, "forgetpass"),style: TextStyle(color: myAmber),),)
                ],
              ),
            ],
          ),
        ),
      ),);
  }
}