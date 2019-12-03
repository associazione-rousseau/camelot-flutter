
import 'package:flutter/widgets.dart';

class BrowserArguments {
  const BrowserArguments({@required this.url, this.title, this.useExternalBrowser, this.color});

  final String url;
  final String title;
  final bool useExternalBrowser;
  final Color color;
}