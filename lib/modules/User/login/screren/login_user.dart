import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';

import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';

import 'package:helpy_app/modules/User/main.dart';

import 'package:helpy_app/modules/otp/otp_register.dart';
import 'package:helpy_app/shared/compononet/custom_dialog.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class LoginIntro extends StatefulWidget {
  @override
  State<LoginIntro> createState() => _LoginIntroState();
}

class _LoginIntroState extends State<LoginIntro> {
  var emailsController = TextEditingController();
  var passsController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<FormState> formState2 = GlobalKey();
  bool myState = false;
  var newPasswordController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailsController = TextEditingController();
    passsController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailsController.dispose();
    passsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, cons_login_Register_States>(
      listener: (ctx, state) {
        if (state is cons_Loading_login) {
          myState = true;
        }
        else if (state is cons_Login_Scusess) {
           // ignore: unrelated_type_equality_checks
           if (state.confirmed == true) {
           navigateTo(context, UserMain());
          // navigateTo(context,CreatePost());
          } else {
            My_CustomAlertDialog(
              icon: Icons.warning_rounded,
              bigTitle: mytranslate(context, "dialogRegistertitle"),
              content: mytranslate(context, "gialogLogin"),
              context: context,
              pressColor: myAmber,
              pressTitle: mytranslate(context, "done"),
              onPress: () {
                Navigator.pop(context);
              },
            );
          }
          myState = false;
        }
      },
      child: FadeIn(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInCirc,
        child: Form(
          key: formState,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.00),
                child: My_TextFormFiled(
                  controller: emailsController,
                  myhintText: mytranslate(context, "email"),
                  validator: (String? s) {
                    if (s!.isEmpty) return "Email is required";
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.00),
                child: My_PasswordFormFiled(
                  suffix: UserCubit.get(context).iconVisiblity,
                  suffixPressed: () {
                    UserCubit.get(context).changPasswordVisibilty();
                  },
                  isPassword: UserCubit.get(context).isPassword,
                  controller: passsController,
                  myhintText: mytranslate(context, "Password"),
                  validator: (String? s) {
                    if (s!.isEmpty) return "Password is required";
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: Mybutton(
                      color: myAmber,
                      context: context,
                      onPress: () async {
                        if (formState.currentState != null && formState.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          try{
                            await UserCubit.get(context).login(emailsController.text, passsController.text);
                          }catch (error) {
                            var errormsg = mytranslate(context, "errorlogin");
                            print('error:${error.toString()}');
                            if (error.toString().contains('INVALID_EMAIL')) {
                              errormsg = "this is not a Valid Email";
                            } else if (error
                                .toString()
                                .contains('INVALID_PASSWORD')) {
                              errormsg = "Incorrect Password";
                            } else if (error
                                .toString()
                                .contains('WEAK_PASSWORD')) {
                              errormsg = "Password Is to weak";
                            } else if (error
                                .toString()
                                .contains('EMAIL_NOT_FOUND')) {
                              errormsg = "This Email is Not Found";
                            }
                            myToast(message: errormsg);
                            myState=false;
                          }
                        }
                      },
                      title: myState
                          ?const SpinKitCircle(
                            color: Colors.white,
                          )
                          : Text(
                        mytranslate(context, "login"),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ))),
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
                          style: const TextStyle(
                            color: Colors.black,
                          )),
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          navigateTo(context, OtpRegister(false));
                        },
                        child: Text(
                          mytranslate(context, "Signup"),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showDialog(
                          context: context,
                          builder: (ctx) => CustomTextFieldDialog(
                              controller: emailController,
                              title: "EnterEmail",
                              buttonText: "Send",
                              hintText: "email",
                              onPressed: () {
                                UserCubit.get(context).sendEmail("users",emailController.text);
                                Navigator.pop(context);
                              }));
                    },
                    child: Text(
                      mytranslate(context, "forgetpass"),
                      style: TextStyle(color: myAmber),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
