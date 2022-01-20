import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/modules/customer/taps/profile/profile.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, Customer_States>(
        listener: (context, state) {
      if (state is LoginChangePassSucessState) {
        myToast(message: mytranslate(context, "reviewemail"));
      } else if (state is LoginChangePassErrorState) {
        myToast(message: "errorpass");
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              mytranslate(context, "changepassword"),
              style: TextStyle(color: HexColor('#C18F3A')),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(15),
              reverse: true,
              shrinkWrap: true,
              //reverse: true,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                  color: HexColor('#C18F3A'),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    UserCubit.get(context)
                        .getUser("Customers", emailController.text);

                    navigateToFinish(context, ProfileScreen());
                  },
                  child: Text(
                    mytranslate(context, "sendurl"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                My_TextFormFiled(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  myhintText: mytranslate(context, "email"),
                  validator: (value) => value!.isEmpty
                      ? 'Enter Your Email'
                      : (validateEmail(value)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(mytranslate(context, "passtext")),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: const ExactAssetImage("assets/pass.png"),
                  height: MediaQuery.of(context).size.height * .30,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ));
    });
  }
}
