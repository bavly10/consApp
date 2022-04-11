import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/lang.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/User/add_file/add_file.dart';

import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/modules/User/profile/Widgets/changePass/changepass.dart';
import 'package:helpy_app/modules/User/profile/Widgets/user_rate/user_rate_screen.dart';
import 'package:helpy_app/modules/User/profile/Widgets/wallet/wallet_screen.dart';
import 'package:helpy_app/modules/User_screen/introducer.dart';

import 'package:helpy_app/modules/customer/taps/profile/edit_profile/widgets/custom_list_tile.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, cons_login_Register_States>(
      builder: (context, state) {
        final model = UserCubit.get(context).loginModel;
        final model2 = UserCubit.get(context).loginModel!.userClass!.id;

        final cubit = cons_Cubit.get(context);
        cons_Cubit.get(context).getMyShared();
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.png'),
                      radius: 50,
                    ),
                    Positioned(
                      // top: 750,
                      left: 10,
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
                              UserCubit.get(context)
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  model?.userClass!.username ?? 'Error',
                  style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#C18F3A'),
                      fontWeight: FontWeight.bold,
                      wordSpacing: 5,
                      letterSpacing: 3),
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
                    padding: const EdgeInsets.only(
                      right: 5,
                      bottom: 8,
                      top: 5,
                    ),
                    child: CustomListTile(
                      textTitle: "changepassword",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {
                        navigateTo(context, ChangePasswordUser());
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                      bottom: 8,
                      top: 5,
                    ),
                    child: CustomListTile(
                      textTitle: "editProfile",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {
                        navigateTo(context, Introducer(model2!));
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
                      textTitle: "wallet",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {
                        navigateTo(context, const WalletScreen());
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                      bottom: 8,
                      top: 5,
                    ),
                    child: CustomListTile(
                      textTitle: "nfile",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {
                        navigateTo(context, CreateFile());
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8, top: 5, right: 16, left: 12),
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (lang) {
                        cubit.changeLang(lang, context);
                      },
                      hint: Text(
                        mytranslate(context, "lang"),
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15),
                      ),
                      // value: lanugage.lang_list[0],
                      items: lanugage.lang_list
                          .map<DropdownMenuItem<lanugage>>(
                              (lang) => DropdownMenuItem(
                                    value: lang,
                                    child: Row(
                                      children: [
                                        Text(lang.flag!),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(lang.name!)
                                      ],
                                    ),
                                  ))
                          .toList(),
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: myAmber,
                        size: 30.0,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                      bottom: 8,
                      top: 5,
                    ),
                    child: CustomListTile(
                      textTitle: "rating",
                      trailingIcon: Icons.arrow_forward_ios_rounded,
                      onTap: () {
                        navigateTo(context, const UserRateScreen());
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
                          CashHelper.removeData("userToken");
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
        );
      },
    );
  }
}
