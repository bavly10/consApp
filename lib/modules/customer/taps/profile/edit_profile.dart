import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, Customer_States>(
        listener: (context, state) {
      if (state is LoadingChangeCustomerImage) {
        myToast(message: mytranslate(context, "loadimage"));
      } else if (state is ChangeCustomerImageSuessState) {
        myToast(message: mytranslate(context, "changproimage"));
      } else if (state is UpdateCustomerDataSucessState) {
        myToast(message: mytranslate(context, "editing"));
      }
    }, builder: (context, state) {
      File? image = CustomerCubit.get(context).imagee;
      var cusImage = CustomerCubit.get(context).myModel?.image;
      return Scaffold(
          appBar: AppBar(
            title: Text(
              mytranslate(context, "editprof"),
              style: TextStyle(color: HexColor('#C18F3A')),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              reverse: true,
              shrinkWrap: true,
              children: [
                ProfileTextField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  hint: '5963585462',
                  validate: (value) => value!.isEmpty
                      ? 'Enter your phone'
                      : validateMobile(value),
                  onSubmit: (value) {
                    print(customerID);
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (formKey.currentState!.validate()) {
                      CustomerCubit.get(context).updateCustomerData(
                          userName: nameController.text,
                          phone: phoneController.text,
                          id: customerID!);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, bottom: 8, top: 8, left: 5),
                  child: Text(
                    mytranslate(context, "phoneno"),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, left: 15),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, left: 15),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13, left: 15),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                  ),
                ),
                ProfileTextField(
                  controller: nameController,
                  type: TextInputType.name,
                  hint: 'احمد علي',
                  validate: (value) => value!.isEmpty
                      ? 'Enter Your Name'
                      : (nameRegExp.hasMatch(value)
                          ? null
                          : 'Enter a Valid Name'),
                  onSubmit: (value) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, bottom: 8, top: 8, left: 5),
                  child: Text(
                    mytranslate(context, "Name"),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                  color: HexColor('#C18F3A'),
                  onPressed: state is TakeImageCustomer_State
                      ? () {
                          print(customerID);
                          CustomerCubit.get(context)
                              .uploadProfileImage(id: customerID!);
                        }
                      : null,
                  child: state is LoadingChangeCustomerImage
                      ? SpinKitCircle(
                          color: myWhite,
                        )
                      : Text(
                          mytranslate(context, "changeimage"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    if(cusImage==null)
                      Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/logo.png'),
                      width: MediaQuery.of(context).size.width * 0.30,
                    )
                    else
                      Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(cusImage),
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                    if (image !=null)
                      Image(
                        image: FileImage(image),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 0.30,
                      ),
                    Positioned(
                      // top: 750,
                      left: 105,
                      child: Center(
                        child: Container(
                          //alignment: AlignmentDirectional.topStart,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            color: HexColor('#C18F3A'),
                          ),
                          //  alignment: Alignment.topRight,
                          height: 20,
                          width: 20,
                          child: InkWell(
                            onTap: () {
                              CustomerCubit.get(context).getImageBloc(ImageSource.gallery);
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.mode_edit_rounded,
                                color: Colors.white54,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
