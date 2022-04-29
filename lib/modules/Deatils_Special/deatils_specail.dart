import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';
import 'package:helpy_app/modules/User_screen/introducer.dart';
import 'package:helpy_app/modules/complian/complian_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroducerSpecial extends StatefulWidget {
  final String spec;
  final int id;
  IntroducerSpecial(this.spec, this.id);

  @override
  State<IntroducerSpecial> createState() => _IntroducerSpecialState();
}

///error hna fe backScreen
class _IntroducerSpecialState extends State<IntroducerSpecial> {
  String imgurl = base_api;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    ConsCubitIntro.get(context).limit = 0;
    ConsCubitIntro.get(context).specIntro = [];
    ConsCubitIntro.get(context).getSpecIntro(widget.id);
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        ConsCubitIntro.get(context).pagnationDataLimit();
        await ConsCubitIntro.get(context).getSpecIntro(widget.id);
        print("new Data Loading");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsCubitIntro, cons_StatesIntro>(
      listener: (context, state) {
        if (state is Cons_NoUsersFound_Special_intro) {
          myToast(message: mytranslate(context, "noData"));
        } else if (state is Cons_ErrorServer_Special_intro) {
          myToast(message: mytranslate(context, "nomoreData"));
        } else if (state is Cons_Error_Special_intro) {
          myToast(message: mytranslate(context, "errorData"));
        }
      },
      builder: (context, state) {
        final cubit = ConsCubitIntro.get(context)
            .specIntro
            .where((element) => element.specailst!.specTitle == widget.spec);
        return SafeArea(
          child: Scaffold(
            body: NestedScrollView(
              controller: scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    pinned: true,
                    floating: true,
                    title: Text(widget.spec,
                        style: TextStyle(fontSize: 22, color: myAmber)),
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: myAmber,
                          )),
                    ],
                    centerTitle: true,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "نتائج البحث :",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${cubit.length}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              body: state is Cons_Loading_Special_intro
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : cubit.isEmpty
                  ? noIntroducer(context)
                  : LayoutBuilder(builder: (context, constraint) {
                return Stack(
                  children: [
                    ListView(
                      physics: BouncingScrollPhysics(),
                      children: cubit
                          .map(
                            (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              navigateTo(context, Introducer(e.id!));
                            },
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: e.introLogo == null
                                          ? const Image(
                                        image: ExactAssetImage(
                                            "assets/logo.png"),
                                        height: 100,
                                      )
                                          : CachedNetworkImage(
                                        width:
                                        double.infinity,
                                        height: 100,
                                        imageUrl: imgurl +
                                            e.introLogo!
                                                .url!,
                                        placeholder: (context,
                                            url) =>
                                        const SpinKitCircle(
                                          color:
                                          Colors.green,
                                        ),
                                        errorWidget: (context,
                                            url,
                                            error) =>
                                        const Icon(Icons
                                            .error),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                e.username,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors
                                                        .black,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              Icon(
                                                Icons.verified,
                                                color: e.typeIntroducer ==
                                                    "Company"
                                                    ? Colors.blue
                                                    : Colors
                                                    .green,
                                                size: 20,
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    ConsCubit.get(context).getMyShared();
                                                    ConsCubit.get(context).customerIDStrapi==null
                                                        ? myToast(
                                                        message: mytranslate(context, "mustlogin"))
                                                        : navigateTo(
                                                        context,
                                                        ComplianScreen(
                                                          user:
                                                          e,
                                                        ));
                                                  },
                                                  child:
                                                  const Icon(
                                                    Icons.report,
                                                    color: Colors
                                                        .grey,
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(e.typeIntroducer!,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: e.typeIntroducer ==
                                                      "Company"
                                                      ? Colors
                                                      .blue
                                                      : Colors
                                                      .green)),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .place_rounded,
                                                color: myAmber,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(e.address ??
                                                  "Error")
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    if (state is Cons_Loading_Special_intro) ...[
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: constraint.maxWidth,
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: myAmber,
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
