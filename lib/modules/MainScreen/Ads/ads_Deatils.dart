import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdsDetails extends StatelessWidget {
  final String url;
   AdsDetails(this.url, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return WebView(
     initialUrl: url,
   );
  }
}
