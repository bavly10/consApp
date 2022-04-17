import 'package:flutter/material.dart';

import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User_screen/tabs/posts/deatils_post.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:intl/intl.dart' as intl;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostsIntro extends StatelessWidget {
  UserStrapi? cubit;
  PostsIntro(this.cubit);
  String imgurl = base_api;
  @override
  Widget build(BuildContext context) {
    return cubit!.posts!.isEmpty
        ? noPostFound(context)
        : ListView(
            children: cubit!.posts!.map((e) {
              DateTime now = DateTime.parse(e.publishedAt.toString());
              String formattedDate =
                  intl.DateFormat('yyyy-MM-dd – kk:mm').format(now).toString();
              return GestureDetector(
                onTap: () {
                  navigateTo(
                      context,
                      DetailsPost(e.content, formattedDate, e.imgPost,
                          imgurl + cubit!.introLogo!.url!, cubit?.username));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 12, left: 4),
                                child: cubit?.introLogo != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            imgurl + cubit!.introLogo!.url!),
                                        radius: 28,
                                      )
                                    : const CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/logo.png'),
                                        radius: 28,
                                      )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit!.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: myAmber),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      formattedDate,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      MdiIcons.earth,
                                      size: 14,
                                      color: Colors.grey[700],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${e.content}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
            physics: const BouncingScrollPhysics(),
          );
  }
}
