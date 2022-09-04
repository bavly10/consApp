import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/customer_model.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/shared/compononet/ProfileTextField.dart';
import 'package:helpy_app/shared/compononet/custom_error_container.dart';
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
    ConsCubit.get(context).getMyShared();

    return BlocConsumer<CustomerCubit, Customer_States>(
      listener: (context, state) {
        if (state is LoadingChangeCustomerImage) {
          myToast(message: mytranslate(context, "loadimage"));
        } else if (state is ChangeCustomerImageSuessState) {
          myToast(message: mytranslate(context, "changproimage"));
          CustomerCubit.get(context)
              .getCustomerData(ConsCubit.get(context).customerID);
        } else if (state is UpdateCustomerDataSucessState) {
          myToast(message: mytranslate(context, "editing"));
          CustomerCubit.get(context)
              .getCustomerData(ConsCubit.get(context).customerID);
        } else if (state is TakeImageCustomer_State) {
          CustomerCubit.get(context)
              .uploadProfileImage(id: ConsCubit.get(context).customerID!);
        } else if (state is UpdateCustomerDataErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(snakBar(context));
        } else if (state is ChangeCustomerImageSuessState) {
          ScaffoldMessenger.of(context).showSnackBar(snakBar(context));
        }
      },
      builder: (context, state) {
        File? image = CustomerCubit.get(context).imagee;
        String? cusImage = CustomerCubit.get(context).model?.image;
        CustomerModel? model = CustomerCubit.get(context).model;

        return Scaffold(
            appBar: AppBar(
              title: Text(
                mytranslate(context, "editprofile"),
                style: TextStyle(color: HexColor('#C18F3A')),
              ),
              centerTitle: true,
            ),
            body: model != null
                ? Form(
                    key: formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(15),
                      reverse: true,
                      shrinkWrap: true,
                      children: [
                        Mybutton(
                          context: context,
                          title: Text(
                            mytranslate(context, "upd"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPress: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // if (formKey.currentState!.validate()) {
                            CustomerCubit.get(context).updateCustomerData(
                                userName: nameController.text == ''
                                    ? model.username
                                    : nameController.text,
                                phone: phoneController.text == ''
                                    ? model.phone
                                    : phoneController.text,
                                id: ConsCubit.get(context).customerID!);
                            // }
                          },
                          color: HexColor('#C18F3A'),
                        ),
                        ProfileTextField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          hint: model.phone,
                          validate: (value) => regExp.hasMatch(value!)
                              ? null
                              : 'Enter Valid Name',
                          onSubmit: (value) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, bottom: 8, top: 8, left: 5),
                          child: Text(
                            mytranslate(context, "phoneno"),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700]),
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
                          hint: model.username,
                          validate: (value) {
                            nameRegExp.hasMatch(value!)
                                ? null
                                : 'Enter a Valid Name';
                          },
                          onSubmit: (value) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, bottom: 8, top: 8, left: 5),
                          child: Text(
                            mytranslate(context, "name"),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            if (cusImage == null)
                              const CircleAvatar(
                                backgroundImage: AssetImage('assets/logo.png'),
                                radius: 50,
                              )
                            else
                              CircleAvatar(
                                backgroundImage: NetworkImage(cusImage),
                                radius: 50,
                              ),
                            if (image != null)
                              CircleAvatar(
                                backgroundImage: FileImage(image),
                                radius: 50,
                              ),
                            Positioned(
                              // top: 750,
                              left: 120,
                              child: Center(
                                child: Container(
                                  //alignment: AlignmentDirectional.topStart,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    shape: BoxShape.rectangle,
                                    color: HexColor('#C18F3A'),
                                  ),
                                  height: 20,
                                  width: 20,
                                  child: InkWell(
                                    onTap: () {
                                      CustomerCubit.get(context)
                                          .getImageBloc(ImageSource.gallery);
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
                  )
                : const CustomErrorContainer());
      },
    );
  }
}
