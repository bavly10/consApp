
import 'package:flutter/material.dart';
import 'package:helpy_app/modules/customer/Chat/Tab/new.dart';
import 'package:helpy_app/modules/customer/Chat/Tab/old.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

import 'Tab/newTest.dart';


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
        child:NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverSafeArea(
              sliver: SliverAppBar(
                leading:const SizedBox(),
                backgroundColor:Colors.white,
                title: const Text("Chats"),
                pinned: true,
                snap: true,
                floating: true,
                bottom: TabBar(
                  indicatorColor: myAmber,
                  indicatorWeight: 2,
                  tabs: [
                    Tab(
                      child: Text(
                        "Currently chat",
                        style: TextStyle(color: myAmber),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "History Chat",
                        style: TextStyle(color:myAmber),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body:TabBarView(
            physics:  NeverScrollableScrollPhysics(),
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
