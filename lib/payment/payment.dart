import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
                await controller
                    .evaluateJavascript(
                        source: "document.documentElement.innerText")
                    .then((value) {
                  if (value.toString().contains("Transaction not completed") ||
                      value.toString().contains("لم تكتمل المعاملة")) {
                    scrollController
                        .jumpTo(scrollController.position.minScrollExtent);
                    navigateToFinish(context, PaymentError(cubit: cubit));

                    navigateToFinish(context, PaymentError(cubit: cubit));
                  } else if (value
                          .toString()
                          .contains("Transaction successful") ||
                      value.toString().contains("معاملة ناجحة")) {
                    scrollController
                        .jumpTo(scrollController.position.minScrollExtent);
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
}
