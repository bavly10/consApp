import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:helpy_app/Cubit/cubit.dart';

import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';
import 'package:helpy_app/modules/customer/Chat/chats_screen.dart';
import 'package:helpy_app/payment/pay_errors/pay_errors.dart';
import 'package:helpy_app/shared/componotents.dart';

class PaymentsTest extends StatelessWidget {
  final String url;
  final int id;
  PaymentsTest(this.url, this.id);
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    ConsCubit.get(context).getMyShared();
    final cubit = ConsCubitIntro.get(context).findbyid(id);
    return BlocBuilder<ConsCubitIntro, cons_StatesIntro>(builder: (ctx, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Going Chat with ${cubit.username}"),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(url)),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true,
                  useOnLoadResource: true,
                  javaScriptEnabled: true,
                ),
              ),
              onLoadStop: (InAppWebViewController controller, url) async {
                await controller.evaluateJavascript(source: "document.documentElement.innerText")
                    .then((value) {
                  if (value.toString().contains("Transaction not completed") ||
                      value.toString().contains("لم تكتمل المعاملة")) {
                    navigateToFinish(context, PaymentError(cubit: cubit,mytext: value,));
                  } else if (
                  value.toString().contains("Transaction successful") ||
                      value.toString().contains("معاملة ناجحة")) {
                    addchat(context,cubit.id.toString(),cubit.username);
                    navigateToFinish(context, ChatsScreen());
                  } else {
                    null;
                  }
                });
              },
            ),
          ),
        ),
      );
    });
  }
  addchat(context,userid,username)async{
    ConsCubit.get(context).getMyShared();
    String? custId=ConsCubit.get(context).customerID;
    final customerdata = await FirebaseFirestore.instance.collection('customers').doc(custId).get();
    final userdata = await FirebaseFirestore.instance.collection('users').doc(userid.toString()).get();
    await FirebaseFirestore.instance.collection("AllChat").doc(custId).set({
      "senderID":userid,
      "myID": custId,
      "nameCustomer": customerdata["username"],
      "imageIntroduce":userdata["imageIntroduce"],
      "imageCustomer":customerdata["imageCustomer"],
      "time":Timestamp.now(),
      "nameIntroduce":username,
    }).then((value) => null);
    await FirebaseFirestore.instance.collection("AllChat").doc(userid.toString()).set({
      "myID":userid,
      "senderID": custId,
      "nameCustomer": customerdata["username"],
      "imageIntroduce":userdata["imageIntroduce"],
      "imageCustomer":customerdata["imageCustomer"],
      "time":Timestamp.now(),
      "nameIntroduce":username,
    }).then((value) =>  myToast(message: "تم اضافه الي قائمه الاصدقاء"));
  }
}
