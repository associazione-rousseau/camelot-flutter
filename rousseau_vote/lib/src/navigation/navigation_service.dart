import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(String route,
      {Object arguments, bool replace = false}) {
    if (replace) {
      navigatorKey.currentState.pushReplacementNamed(route, arguments: arguments);
    } else {
      navigatorKey.currentState.pushNamed(route, arguments: arguments);
    }
  }

  bool goBack() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
      return true;
    }
    return false;
  }
}