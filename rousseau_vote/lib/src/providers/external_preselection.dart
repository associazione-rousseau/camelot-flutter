import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart';

@singleton
class ExternalPreselection with ChangeNotifier {
  ExternalPreselection() {
    initUniLinks();
  }

  @factoryMethod
  static Future<ExternalPreselection> create() async {
    return ExternalPreselection();
  }

  static const String CATEGORY = 'rousseau.provider.deeplinks';

  String link = '';
  String id = '';
  StreamSubscription<String> _sub;

  Future<Null> initUniLinks() async {

    developer.log('[[initUniLinks]]', name: CATEGORY);

    // should happen on create application
    final String initialLink = await getInitialLink();
    if(initialLink != null) {
      developer.log('initial link: $initialLink', name: CATEGORY);

      link = initialLink;
      id = _findId(link);

      notifyListeners();
    }

    // should happen on background application
    _sub = getLinksStream().listen((String link) {
      developer.log('link: $link', name: CATEGORY);

      this.link = link;
      id = _findId(link);

      notifyListeners();

    }, onError: (dynamic err) {
      developer.log('error: $err', name: CATEGORY);
    });
  }

  static String _findId(String url) {

    final RegExp exp = RegExp(r'\/([0-9a-zA-Z=]+)\/?$');

    if(exp.hasMatch(url)) {
      String match = exp.firstMatch(url).group(1);
      developer.log('match: $match', name: CATEGORY);
      return match;
    }

    return '';
  }
}