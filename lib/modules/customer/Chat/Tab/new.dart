import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/shared/compononet/custom_empty.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';

import '../../../Chat/Message/Message_screen.dart';

class newTest extends StatefulWidget {
  const newTest({Key? key}) : super(key: key);

  @override
  _newTestState createState() => _newTestState();
}

class _newTestState extends State<newTest> {
  String? myid, senderid, username, introduceimg;
  int? diff1;
  List<int> diff = [];

  @override
  Widget build(BuildContext context) {
    ConsCubit.get(context).getMyShared();
    ConsCubit.get(context).getID();

    print(myid);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("AllChat")
              .doc(ConsCubit.get(context).localID)
              .collection('contact')
              .where("myID", isEqualTo: ConsCubit.get(context).localID!)
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitCircle(
                color: myAmber,
              );
            }
            final docs = snapshot.data!.docs;

            var nowDate = DateTime.now();

            var allData = [];

            docs.forEach((element) {
              allData = [];
              diff = [];

              docs.map((element) {
                var e = element.get('time');
                DateTime dateTime2 = DateTime.parse(e.toDate().toString());
                diff1 = nowDate.difference(dateTime2).inHours;
                diff.add(diff1!);
                // print("difference time is $diff1");
                if (diff1! < 48) {
                  print("difference time is $diff1");
                  allData.add(element.data());
                  ConsChat.get(context).isClose = false;
                  // print(allData.toString());
                }
              }).toList();
            });
            UserCubit.get(context).numNew = allData.length.toString();
            return allData.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      print(allData.length);
                      {
                        return InkWell(
                          onTap: () {
                            senderid = allData[index]['senderID'].toString();
                            myid = allData[index]['myID'].toString();
                            username = allData[index]['sendername'];
                            introduceimg = allData[index]['senderimage'];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => MessagesScreen(myid!,
                                        username!, senderid!, introduceimg!)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding * 0.75),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(
                                          allData[index]['senderimage']),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allData[index]['sendername'],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blueGrey),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                                //Spacer(),

                                Opacity(
                                  opacity: .8,
                                  child: Text(
                                    "${diff[index].toString()}  ${mytranslate(context, "hours")}",
                                    style: TextStyle(
                                        color: myAmber,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // : SizedBox();
                    },
                    itemCount: allData.length,
                  )
                : CustomEmpty(
                    text: mytranslate(context, "nothing"),
                  );
          }),
    );
  }
}
