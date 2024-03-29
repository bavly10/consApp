import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User_screen/slide_dialog.dart';
import 'package:helpy_app/modules/User_screen/tabs/about.dart';
import 'package:helpy_app/modules/User_screen/tabs/posts/posts.dart';
import 'package:helpy_app/modules/User_screen/tabs/services.dart';
import 'package:helpy_app/modules/customer/Chat/chats_screen.dart';
import 'package:helpy_app/modules/customer/cubit/cubit.dart';
import 'package:helpy_app/payment/payment.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;

import '../Chat/cubit.dart';
import '../customer/cubit/state.dart';

class Introducer extends StatelessWidget {
  final int id;

  Introducer(this.id);
  String imgurl = base_api;
  Color mycolor = Colors.white;
  List<String> images = ["assets/logo.png"];
  @override
  Widget build(BuildContext context) {
    ConsCubit.get(context).getMyShared();
    return BlocConsumer<ConsCubitIntro, cons_StatesIntro>(
        listener: (ctx, state) {
      if (state is Cons_Payment_Loading) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  insetPadding: const EdgeInsets.all(8),
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
                                mytranslate(context, "surely"),
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
                  contentPadding: const EdgeInsets.all(8),
                ));
      } else if (state is Cons_Payment_done) {
        navigateTo(context, PaymentsTest(state.url, id));
      } else if (state is Cons_Payment_notdone) {
        EasyLoading.showToast(state.error,
            toastPosition: EasyLoadingToastPosition.bottom,
            duration: const Duration(seconds: 3));
      }
    }, builder: (context, state) {
      ConsCubit.get(context).getMyShared();
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
                cubit.introImg!.isEmpty
                    ? const Image(
                        image: ExactAssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                      )
                    : CarouselSlider(
                        carouselController: CarouselControllerImpl(),
                        items: cubit.introImg!
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
                                  placeholder: (context, url) => SpinKitCircle(
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
                            scrollDirection: Axis.horizontal)),
                Positioned(
                  top: MediaQuery.of(context).size.height * .20,
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
                                Text(cubit.city ?? "Error"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cubit.address ?? "Error",
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
            ConsCubit.get(context).getMyShared();
            if (ConsCubit.get(context).customerToken == null) {
              slideDialog.showSlideDialog(
                  pillColor: myAmber,
                  backgroundColor: Colors.white,
                  context: context,
                  child: MySlideDialog(
                      cubit.username, mytranslate(context, "connect")));
            } else {
              var model = CustomerCubit.get(context).model;
              CustomerCubit.get(context)
                  .getCustomerData(ConsCubit.get(context).customerID)
                  .then((value) async {
                ConsCubit.get(context).sendAddingNotification(
                    name: 'users',
                    id: id,
                    tittle: "Surely",
                    body: mytranslate(context, "adding"),
                    nameSender: model?.username ?? "",
                    context: context);
                print(cubit.username);
                UserCubit.get(context).changePoint(cubit.points, id, context);

                if (model?.walletPoint == null) {
                  addchat(context, cubit.id.toString(), cubit.username);
                  // await ConsCubitIntro.get(context).getPay(
                  //     user: cubit.username,
                  //     name: model!.username,
                  //     email: model.email,
                  //     phone: model.phone,
                  //     amount: cubit.introPrice);
                } else {
                  My_CustomAlertDialog(
                    pressTitle: mytranslate(context, "done"),
                    icon: Icons.wallet_giftcard,
                    iconColor: myAmber,
                    onPress: () {
                      navigateToFinish(context, ChatsScreen());
                    },
                    content: mytranslate(context, "walletp") +
                        "\n" +
                        mytranslate(context, "valid"),
                    context: context,
                    bigTitle: mytranslate(context, "surely"),
                    pressColor: myAmber,
                  );
                }
              });
            }
          },
          label: Row(
            children: [
              const Text('Connect'),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${cubit.introPrice} SR',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          backgroundColor: Colors.yellow.shade800,
        ),
      );
    });
  }

  addchat(context, userid, username) async {
    ConsCubit.get(context).getMyShared();
    String? custId = ConsCubit.get(context).customerID;
    final customerdata = await FirebaseFirestore.instance
        .collection('customers')
        .doc(custId)
        .get();
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid.toString())
        .get();
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(custId)
        .collection('contact')
        .doc(userid)
        .set({
      "senderID": userid,
      "myID": custId,
      "myname": customerdata["username"],
      "sendername": username,
      "myimage": customerdata["imageCustomer"],
      "senderimage": userdata["imageIntroduce"],
      "typing": "false",
      "time": Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(userid.toString())
        .collection('contact')
        .doc(custId)
        .set({
      "myID": userid,
      "senderID": custId,
      "myname": username,
      "sendername": customerdata["username"],
      "myimage": userdata["imageIntroduce"],
      "senderimage": customerdata["imageCustomer"],
      "typing": "false",
      "time": Timestamp.now(),
    }).then((value) => myToast(message: "تم اضافه الي قائمه الاصدقاء"));
  }
}
