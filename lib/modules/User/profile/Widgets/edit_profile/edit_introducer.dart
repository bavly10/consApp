import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User_screen/tabs/about.dart';
import 'package:helpy_app/modules/User_screen/tabs/posts/posts.dart';
import 'package:helpy_app/modules/User_screen/tabs/services.dart';

import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditIntroducer extends StatelessWidget {
  // final int id;
  LoginModel? loginmodel;

  EditIntroducer(this.loginmodel);

  String imgurl = base_api;
  Color mycolor = Colors.white;
  List<Widget> items = [
    const Image(image: AssetImage("assets/logo.png")),
  ];
  List<String> images = ["assets/logo.png"];

  @override
  Widget build(BuildContext context) {
    cons_Cubit.get(context).getMyShared();
    return BlocConsumer<UserCubit, cons_login_Register_States>(
        listener: (ctx, state) {
      if (state is TakeImage_State) {
        UserCubit.get(context)
            .uploadProfileUserImage(id: cons_Cubit.get(context).userFBID!);
        print(cons_Cubit.get(context).userFBID);
        UserCubit.get(context).uploadImage(
            UserCubit.get(context).imagee!.readAsBytesSync(),
            loginmodel!.userClass!.id);
        UserCubit.get(context).uploadImage(
            UserCubit.get(context).imagee!.readAsBytesSync(),
            loginmodel!.userClass!.id);
      } else if (state is TakeImagess_State) {
        //  UserCubit.get(context).uploadIntro My_CustomAlertDialog(
        My_CustomAlertDialog(
          pressTitle: mytranslate(context, "done"),
          icon: Icons.update,
          iconColor: myAmber,
          onPress: () {
            UserCubit.get(context)
                .uploadImagesStrapi(loginmodel!.userClass!.id, "intro_img");
            Navigator.pop(context);
          },
          content: mytranslate(context, "choose") +
              UserCubit.get(context).myimagecount.toString() +
              "\n" +
              mytranslate(context, "sure"),
          context: context,
          bigTitle: mytranslate(context, "surely"),
          pressColor: myAmber,
        );
      } else if (state is ChangeUserImageSuessState) {
        myToast(message: mytranslate(context, "changproimage"));
      } else if (state is LoadingChangeUserImageState) {
        myToast(
            message: mytranslate(context, mytranslate(context, "loadimage")));
      } else if (state is ChangeUserImageErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(snakBar(context));
      } else if (state is ChangeCoverUserImageSuessState) {
        myToast(message: mytranslate(context, "covers"));
      } else if (state is ChangeCoverUserImageErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(snakBar(context));
      }
    }, builder: (context, state) {
      File? image = UserCubit.get(context).imagee;
      var introLogo = UserCubit.get(context).loginModel!.userClass!.introLogo;
      var introImg = UserCubit.get(context).loginModel?.userClass?.introImg;
      var cubit = UserCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            mytranslate(context, "details"),
            style: TextStyle(color: myAmber),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.35),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    if (introImg!.isNotEmpty)
                      CarouselSlider(
                          carouselController: CarouselControllerImpl(),
                          items: loginmodel!.userClass!.introImg!
                              .map((e) => CachedNetworkImage(
                                    imageUrl: imgurl + e.url!,
                                    fit: BoxFit.fill,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        SpinKitCircle(
                                      color: myAmber,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              enableInfiniteScroll: true,
                              viewportFraction: 1.0,
                              onPageChanged: (int i, _) {},
                              autoPlayInterval: const Duration(seconds: 2),
                              enlargeCenterPage: true,
                              initialPage: 0,
                              autoPlay: true,
                              scrollDirection: Axis.horizontal))
                    else if (cubit.result?.files != null)
                      CarouselSlider(
                          carouselController: CarouselControllerImpl(),
                          items: cubit.result!.files
                              .map((e) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                        image: DecorationImage(
                                            image: FileImage(File(e.path!)),
                                            fit: BoxFit.fill)),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              enableInfiniteScroll: true,
                              viewportFraction: 1.0,
                              onPageChanged: (int i, _) {},
                              autoPlayInterval: const Duration(seconds: 4),
                              enlargeCenterPage: true,
                              autoPlay: true,
                              initialPage: 0,
                              scrollDirection: Axis.horizontal))
                    else
                      CarouselSlider(
                          carouselController: CarouselControllerImpl(),
                          items: images.map<Widget>((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                        image: DecorationImage(
                                            image: AssetImage(i))));
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              enableInfiniteScroll: true,
                              viewportFraction: 1.0,
                              onPageChanged: (int i, _) {},
                              autoPlayInterval: const Duration(seconds: 4),
                              enlargeCenterPage: true,
                              autoPlay: true,
                              initialPage: 0,
                              scrollDirection: Axis.horizontal)),
                    Positioned(
                      //top: 190,
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
                          height: 23,
                          width: 23,
                          child: InkWell(
                            onTap: () {
                              UserCubit.get(context)
                                  .pickFiles(['jpg', 'png'], true);
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
                Positioned(
                  top: MediaQuery.of(context).size.height * .20,
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Card(
                      elevation: 8,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        width: 140,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            if (introLogo != null)
                              CachedNetworkImage(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                width: double.infinity,
                                imageUrl: imgurl +
                                    loginmodel!.userClass!.introLogo!.url!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const SpinKitCircle(
                                  color: Colors.green,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            else
                              const Image(
                                image: AssetImage('assets/logo.png'),
                              ),
                            if (image != null)
                              Image(
                                image: FileImage(image),
                                fit: BoxFit.fill,
                              ),
                            Positioned(
                              top: 63,
                              left: 2,
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              loginmodel!.userClass!.username,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: myAmber, fontSize: 20),
            ),
            DefaultTabController(
              length: 3,
              child: Container(
                margin: const EdgeInsets.all(15),
                color: mycolor,
                height: MediaQuery.of(context).size.height * 0.50,
                child: NestedScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context)),
                    SliverSafeArea(
                      sliver: SliverAppBar(
                        leading: const SizedBox(),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.place_rounded,
                                  color: myAmber,
                                ),
                                Text(loginmodel!.userClass!.city ?? "Error"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                loginmodel!.userClass!.address ?? "Error",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: mycolor,
                        pinned: true,
                        snap: true,
                        floating: true,
                        bottom: TabBar(
                          indicatorColor: myAmber,
                          indicatorWeight: 2,
                          tabs: [
                            Tab(
                              child: Text(
                                mytranslate(context, "feeds"),
                                style: TextStyle(color: myAmber),
                              ),
                            ),
                            Tab(
                              child: Text(
                                mytranslate(context, "Files"),
                                style: TextStyle(color: myAmber),
                              ),
                            ),
                            Tab(
                              child: Text(
                                mytranslate(context, "about"),
                                style: TextStyle(color: myAmber),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      PostsIntro(loginmodel!.userClass!),
                      ServicesIntro(loginmodel!.userClass!),
                      AboutIntro(loginmodel!.userClass!),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      );
    });
  }
}
