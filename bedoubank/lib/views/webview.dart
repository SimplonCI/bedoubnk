import 'package:bedoubank/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String url = Global().env.apiBaseUrl+'/index.php';
  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
//      url: 'http://192.168.43.175/Webdoc/project/etatcivil/index.html',

      url: url,
      appBar: AppBar(
        title: new Text('BedouBnk'),
      ),
      allowFileURLs: true,
      withJavascript: true,

    );
  }
}
