import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewContainer extends StatefulWidget {
  @override
  createState() => _WebViewContainerState();
}
class _WebViewContainerState extends State<WebViewContainer> {
  var _url='https://www.youtube.com/watch?v=yFlhTvxcrQ8';
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: WebView(
            key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: _url));
  }
}