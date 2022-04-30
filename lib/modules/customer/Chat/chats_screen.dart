import 'package:flutter/material.dart';
import 'package:helpy_app/modules/customer/Chat/Tab/new.dart';
import 'package:helpy_app/modules/customer/Chat/Tab/old.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

import 'Tab/new.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverSafeArea(
              sliver: SliverAppBar(
                leading: const SizedBox(),
                backgroundColor: Colors.white,
                title: Text(mytranslate(context, "Chats")),
                pinned: true,
                snap: true,
                floating: true,
                bottom: TabBar(
                  indicatorColor: myAmber,
                  indicatorWeight: 2,
                  tabs: [
                    Tab(
                      child: Text(
                        mytranslate(context, "chat"),
                        style: TextStyle(
                            color: myAmber, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        mytranslate(context, "oldchat"),
                        style: TextStyle(
                            color: myAmber, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              newTest(),
              OldChat(),
            ],
          ),
        ),
      ),
    );
  }
}
