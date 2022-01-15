import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';

import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/modules/customer/main.dart';

import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/shared/compononet/custom_dialog.dart';

import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:http/http.dart';

class LoginUser extends StatefulWidget {
  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  var emailController = TextEditingController();
  var emailCheckController = TextEditingController();
  var passController = TextEditingController();
  var newPasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  bool myState = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailCheckController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailCheckController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, Customer_States>(
      builder: (ctx, state) {
        return FadeIn(
          duration: const Duration(seconds: 1),
          curve: Curves.bounceInOut,
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.00),
                  child: My_TextFormFiled(
                    controller: emailController,
                    myhintText: mytranslate(context, "email"),
                    validator: (value) => value!.isEmpty
                        ? 'Email is required'
                        : validateEmail(value),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.00),
                  child: My_TextFormFiled(
                    validator: (String? s) {
                      if (s!.isEmpty) return "Password is required";
                    },
                    controller: passController,
                    myhintText: mytranslate(context, "Password"),
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
                          if (_form.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            try {
                              await CustomerCubit.get(context)
                                  .signin(
                                  emailController.text, passController.text)
                                  .then((value) {
                                navigateTo(context, MainCustomer());

                                ///if le gay mn forget pass= true e3ml dialog hn3ml fe textfield password w ha5od pass e3mlo update mn email ely da5l be
                                ///lw false go to mainscreen
                              });
                            } catch (error) {
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
                            }
                          }
                        },
                        title: state is LoginLoadingState
                            ? SpinKitCircle(
                          color: myWhite,
                        )
                            : Text(mytranslate(context, "login"), style: const TextStyle(color: Colors.white, fontSize: 18),))),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => CustomTextFieldDialog(
                            controller: emailCheckController,
                            title: "EnterEmail",
                            buttonText: "Send",
                            hintText: "email",
                            onPressed: () {
                              Navigator.pop(context);
                              UserCubit.get(context).getUser("Customers",emailCheckController.text);
                              myToast(message: "Emailissent");
                            }));
                  },
                  child: Text(
                    mytranslate(context, "forgetpass"),
                    style: TextStyle(color: myAmber),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
