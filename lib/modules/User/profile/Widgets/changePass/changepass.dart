import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/modules/customer/taps/profile/profile.dart';
import 'package:helpy_app/shared/compononet/custom_dialog.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangePasswordUser extends StatelessWidget {
  ChangePasswordUser({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cons_Cubit.get(context).getMyShared();
    UserCubit.get(context).getUserDetails(cons_Cubit.get(context).userID);
    final model = UserCubit.get(context).loginModel;
    return BlocConsumer<UserCubit, cons_login_Register_States>(
        listener: (context, state) {
      if (state is LoginChangePassSucessState) {
        My_CustomAlertDialog(
            context:context,
            bigTitle: mytranslate(context, "reviewemail"),
            content: mytranslate(context, "editpass"),
            pressText: (){
              Navigator.pop(context);
              CashHelper.removeData("userToken");
              navigateToFinish(context, Main_login());
            },
            pressTitle:mytranslate(context, "logout"), icon: Icons.add, pressColor: myAmber);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0)),
                    color: HexColor('#C18F3A'),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (formKey.currentState!.validate()) {
                        UserCubit.get(context).sendEmailPassword("users",model!.userClass!.email,model.userClass!.id);
                      }
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
                ),
                Text("${model!.userClass!.email}",style: TextStyle(color: myAmber,fontWeight: FontWeight.bold,fontSize: 20.0),),
               const SizedBox(
                  height: 10,
                ),
                Text(mytranslate(context, "passtext")),
                const SizedBox(height: 10,),
                Image(
                  image: const ExactAssetImage("assets/pass.png"),
                  height: MediaQuery.of(context).size.height * .30,
                  width: double.infinity,
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ));
    });
  }
}
