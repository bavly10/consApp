import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/MainScreen/home_services.dart';
import 'package:helpy_app/modules/MainScreen/main_screen.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/modules/customer/main.dart';
import 'package:helpy_app/shared/compononet/custom_clip_slider.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class ComplianScreen extends StatelessWidget {
  UserStrapi? user;

  ComplianScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    var subController = TextEditingController();
    var detController = TextEditingController();
    ConsCubit.get(context).getMyShared();
    return BlocConsumer<CustomerCubit, Customer_States>(
        listener: (context, state) {
      if (state is AddUserComplianSueeeState) {
        My_CustomAlertDialog(
          icon: Icons.done,
          iconColor: myAmber,
          pressTitle: mytranslate(context, "done"),
          onPress: () {
            navigateToFinish(context, MainCustomer());

            // navigateTo(context, SpecialList(cat!));
            // navigateToFinish(context, HomeServices());
          },
          content: mytranslate(context, "sentcomp"),
          context: context,
          bigTitle: mytranslate(context, "surely"),
          pressColor: myAmber,
        );
      } else if (state is AddUserComplianErrorState) {
        myToast(message: mytranslate(context, "failedcomp"));
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: myAmber,
        appBar: AppBar(
          title: Text(mytranslate(context, "report")),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ClipPath(
                  clipper: TsClip1(),
                  child: Container(
                    // color: myAmber,
                    height: MediaQuery.of(context).size.height * .30,
                    width: MediaQuery.of(context).size.width,
                    child: const Image(
                      //color: Colors.transparent,
                      image: AssetImage(
                        'assets/123.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        mytranslate(context, "to"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Text(
                      user!.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: DropdownButton<String>(
                        // autofocus: true,
                        isExpanded: true,
                        focusColor: myAmber,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(mytranslate(context, "type")),
                        ),
                        dropdownColor: Colors.white,
                        value: CustomerCubit.get(context).selectedText,
                        items: <String>[
                          mytranslate(context, "res1"),
                          mytranslate(context, "res2"),
                          mytranslate(context, "res3"),
                          mytranslate(context, "res4"),
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700]),
                                ),
                              ));
                        }).toList(),
                        onChanged: (String? val) {
                          CustomerCubit.get(context).changSelected(val);
                        },
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    maxLines: 5,
                    validator: (String? s) {
                      if (s!.isEmpty) return "details is required";
                    },
                    controller: detController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#F7F7F7'),
                      hintText: mytranslate(context, "decribe"),
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Mybutton(
                      context: context,
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          CustomerCubit.get(context).addComplian(
                              CustomerCubit.get(context).selectedText!,
                              detController.text,
                              user!.id!,
                              ConsCubit.get(context).customerIDStrapi!);
                        }
                      },
                      title: Text(
                        mytranslate(context, "Send"),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
