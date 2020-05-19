import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/init/startup_initializer.dart';
import 'package:rousseau_vote/src/screens/splash_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen(this.showAfterInit, this.startupInitializer);

  final StartupInitializer startupInitializer;
  final String showAfterInit;

  @override
  _InitScreenState createState() =>
      _InitScreenState(showAfterInit, startupInitializer);
}

class _InitScreenState extends State<InitScreen> {
  _InitScreenState(this._showAfterInit, this._startupInitializer);

  final StartupInitializer _startupInitializer;
  final String _showAfterInit;

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }

  @override
  void initState() {
    super.initState();
    _startupInitializer.doInitialize().whenComplete(() {
      Navigator.of(context).pushReplacementNamed(_showAfterInit);
    });
  }
}
