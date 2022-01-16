import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterCustomer extends StatefulWidget {
  final String email;
  // ignore: use_key_in_widget_constructors
  const RegisterCustomer(this.email);

  @override
  State<RegisterCustomer> createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    aboutController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit,Customer_States>(
      listener: (ctx, state) {
        /// success
        if (state is RegisterSuccessState) {
          ///go to payment
          My_CustomAlertDialog(
            bigTitle: mytranslate(context, "customerTitle"),
            content: mytranslate(context, "cusomterdone"),
            context: context,
            pressTitle:mytranslate(context, "done"),
            pressColor:myAmber,
            icon: MdiIcons.checkCircleOutline,
            pressText: () {
            ///go To payment with sqflite data user
              navigateToFinish(context, Main_login());
            },);
        }
        ///lw fe error mn database
        else if (state is RegisterErrorState) {
          myToast(message: "Can't Connect Please Try again later");
        }

        /// format exception e7tyAty
        else if (state is RegisterFinalErrorState) {
          myToast(message: "Try again Later");
        }

        ///lw kol 7aga tmm bs mfe4 net 3nd el user
        else if (state is RegisterErrorXState) {
          myToast(message: "Check Your internet");
        }
      },
      builder: (ctx, state) {
        final cubit=CustomerCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              mytranslate(context, "Register"),
              style: TextStyle(color: myAmber, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:  Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: form,
                child: Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: double.infinity,
                      image:const ExactAssetImage("assets/logo.png"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      mytranslate(context, "registerText"),
                      style:const TextStyle(height: 1.4, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Text(
                            mytranslate(context, "registerText2"),
                            style:const TextStyle(height: 1.4, fontSize: 13),
                          ),
                        ),
                        Flexible(
                          flex:4,
                          child: Text(widget.email,style: TextStyle(color: myAmber,
                              fontSize: 12 ,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textForm(context),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Mybutton(
                          color: myAmber,
                          context: context,
                          onPress: () async {
                            FocusScope.of(context).unfocus();
                            if (form.currentState!.validate()) {
                              try{
                                await cubit.register(
                                  email: widget.email,
                                  username: nameController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,);
                              }on FirebaseException catch (e) {
                                var emesage = "Error In Signup";
                                if (e.code == 'email-already-in-use') {
                                  emesage = ('The account already exists for that email.');
                                }
                                My_CustomAlertDialog(
                                  bigTitle: "MyCompany",
                                  content: emesage,
                                  context: context,
                                  pressTitle:mytranslate(context, "done"),
                                  pressColor:myAmber,
                                  icon: MdiIcons.alert,
                                  pressText: () {
                                    Navigator.pop(context);
                                  },);
                              }
                              catch(e){
                                print(e);
                              }
                            }
                          },
                          title: state is RegisterLoadingState
                              ? const SpinKitCircle(
                            color: Colors.white,
                          )
                              : Text(
                            mytranslate(context, "Register"),
                            style:const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )),
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
  Widget textForm(context) => Column(
    children: [
      My_TextFormFiled(
        validator:(String? s){if(s!.isEmpty)return  "name is required";},
        controller: nameController,
        myhintText: mytranslate(context, "name"),
      ),
      const SizedBox(
        height: 15,
      ),
      const  SizedBox(
        height: 15,
      ),
      My_TextFormFiled(
        validator:(String? s){
          if(s!.isEmpty) {
            return  "Password is required";
          }
          else if (s.length < 6) {
            return "Too Short Number";
          } else {return null;}
        },
        maxLines: 1,
        obscureText: true,
        controller: passwordController,
        myhintText: mytranslate(context, "Password"),
      ),
      const  SizedBox(
        height: 15,
      ),
      My_TextFormFiled(
        textInputType: TextInputType.number,
        validator:(String? s){
          if(s!.isEmpty) {
            return  "Number is required";
          }
          else if (s.length < 9) {
            return "Too Short Number";
          } else if (!s.startsWith("05")&&!s.startsWith("966")) {
            return "invalid Mobile Number";
          } else {return null;}
        },
        controller: phoneController,
        myhintText: mytranslate(context, "phone"),
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}


