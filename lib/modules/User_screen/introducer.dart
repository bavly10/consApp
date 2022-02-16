import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';

import 'package:helpy_app/modules/User_screen/slide_dialog.dart';
import 'package:helpy_app/modules/User_screen/tabs/about.dart';
import 'package:helpy_app/modules/User_screen/tabs/posts/posts.dart';
import 'package:helpy_app/modules/User_screen/tabs/services.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/modules/otp/otp_register.dart';
import 'package:helpy_app/payment/payment.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;

class Introducer extends StatelessWidget {
  final int id;

  Introducer(this.id);

  List imglist = ['assets/as.png', 'assets/ae.jpg', 'assets/ar.jpg'];
  String imgurl = base_api;
  Color mycolor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsCubitIntro, cons_StatesIntro>(
        listener: (ctx, state) {
      if (state is Cons_Payment_Loading) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.all(8),
                  elevation: 10,
                  titlePadding: const EdgeInsets.all(0.0),
                  title: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Column(
                            children: [
                              Text(
                                "Company",
                                style: TextStyle(
                                    color: myAmber,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              CircularProgressIndicator(
                                color: myAmber,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  contentPadding: EdgeInsets.all(8),
                ));
      } else if (state is Cons_Payment_done) {
        navigateTo(context, PaymentsTest(state.url, id));
      } else if (state is Cons_Payment_notdone) {
        EasyLoading.showToast(state.error,
            toastPosition: EasyLoadingToastPosition.bottom,
            duration: const Duration(seconds: 3));
      }
    }, builder: (context, state) {
      final cubit = ConsCubitIntro.get(context).findbyid(id);
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
                CarouselSlider(
                    carouselController: CarouselControllerImpl(),
                    items: imglist
                        .map((e) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0)),
                                image: DecorationImage(
                                    image: ExactAssetImage(e.toString()),
                                    fit: BoxFit.fill))))
                        .toList(),
                    options: CarouselOptions(
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        onPageChanged: (int i, _) {},
                        autoPlayInterval: const Duration(seconds: 2),
                        enlargeCenterPage: true,
                        initialPage: 0,
                        autoPlay: true,
                        scrollDirection: Axis.horizontal)),
                Positioned(
                  top: 140,
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: cubit.introLogo == null
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundImage: ExactAssetImage("assets/logo.png"))
                        : Card(
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
                                  CachedNetworkImage(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: double.infinity,
                                    imageUrl: imgurl + cubit.introLogo!.url!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SpinKitCircle(
                                      color: Colors.green,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  const Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Icon(
                                      MdiIcons.checkCircle,
                                      size: 25,
                                      color: Colors.white,
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
              cubit.username,
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
                                Text(cubit.city ?? "Sharjah"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cubit.address ??
                                    "Ali jasar andalous block 3 street 1 building 232",
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
                      PostsIntro(cubit),
                      ServicesIntro(cubit),
                      AboutIntro(cubit),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            cons_Cubit.get(context).getMyShared();
            if (cons_Cubit.get(context).customerToken == null) {
              slideDialog.showSlideDialog(
                  pillColor: myAmber,
                  backgroundColor: Colors.white,
                  context: context,
                  child: MySlideDialog(
                      cubit.username, mytranslate(context, "connect")));
            } else {
              CustomerCubit.get(context)
                  .getCustomerData(cons_Cubit.get(context).customerID)
                  .then((value) async {
                var model = CustomerCubit.get(context).model;

                ///payment method
                await ConsCubitIntro.get(context).getPay(
                    user: cubit.username,
                    name: model!.username,
                    email: model.email,
                    phone: model.phone,
                    amount: 30);
              });
              // await CustomerCubit.get(context).addUserINChat(cubit.id.toString(), cubit.username,customerID!);
            }
          },
          label: Row(
            children: [
              const Text('Connect'),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${cubit.introPrice}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          backgroundColor: Colors.yellow.shade800,
        ),
      );
    });
  }
}
