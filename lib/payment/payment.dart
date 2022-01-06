import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PaymentsTest extends StatelessWidget {
final String url;
  const PaymentsTest(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
           const SizedBox(height: 10,),
            const Text("Tran id ")
          ],
        ),
      ),
    );
  }
}
