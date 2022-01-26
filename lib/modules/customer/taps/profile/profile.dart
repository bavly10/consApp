import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/modules/customer/taps/profile/change_pass.dart';
import 'package:helpy_app/modules/customer/taps/profile/edit_profile.dart';

import 'package:helpy_app/modules/customer/taps/profile/edit_profile/widgets/custom_list_tile.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, Customer_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = CustomerCubit.get(context).model;
        var cusImage = CustomerCubit.get(context).model?.image;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (cusImage == null)
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.png'),
                      radius: 50,
                    ),
                  if (cusImage != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(cusImage),
                      radius: 50,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    model?.username ?? 'Error',
                    style: TextStyle(
                        fontSize: 18,
                        color: HexColor('#C18F3A'),
                        fontWeight: FontWeight.bold,
                        wordSpacing: 5,
                        letterSpacing: 3),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 5,
                        top: 15,
                      ),
                      child: CustomListTile(
                        textTitle: "editprofile",
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                        onTap: () {
                          navigateTo(context, EditProfile());
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 13, left: 15),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 8,
                        top: 5,
                      ),
                      child: CustomListTile(
                        textTitle: "changepassword",
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                        onTap: () {
                          navigateTo(context, ChangePassword());
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 13, left: 15),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 8,
                        top: 5,
                      ),
                      child: CustomListTile(
                        textTitle: "condition",
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                        onTap: () {},
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 13, left: 15),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 8,
                        top: 5,
                      ),
                      child: CustomListTile(
                        textTitle: "contactus",
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                        onTap: () {},
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 13, left: 15),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 8,
                        top: 5,
                      ),
                      child: CustomListTile(
                          textTitle: "signout",
                          trailingIcon: Icons.arrow_forward_ios_rounded,
                          onTap: () {
                            CashHelper.removeData("tokenCustomer");
                            CashHelper.removeData("cust_id");
                            navigateToFinish(context, Main_login());
                          })),
                  Padding(
                    padding: const EdgeInsets.only(right: 13, left: 15),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
