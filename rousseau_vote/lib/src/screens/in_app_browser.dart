
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/browser_arguments.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowser extends StatelessWidget {

  const InAppBrowser(this.arguments);

  final BrowserArguments arguments;

  static const String ROUTE_NAME = '/inAppBrowser';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RousseauAppBar(),
        body: WebView(
            initialUrl: arguments.url,
            userAgent: IN_APP_BROWSER_USER_AGENT,
        )
    );
  }
}