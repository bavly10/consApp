import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../User/cubit/cubit.dart';

class DetailsPost extends StatelessWidget {
  final String? content, publishedAt, url, username, imgeUrl;
  final Img_user? img_user;
  const DetailsPost(this.content, this.publishedAt, this.img_user, this.url,
      this.username, this.imgeUrl,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, cons_login_Register_States>(
        builder: ((context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(mytranslate(context, "post_details")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(url!), radius: 40),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      username!,
                      style: TextStyle(
                          color: myAmber,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            publishedAt!,
                            style: const TextStyle(color: Colors.grey),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$content",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    if (img_user != null)
                      Container(
                        height: MediaQuery.of(context).size.height * .33,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                                image:
                                    NetworkImage(imgeUrl! + img_user!.url!))),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }
}
