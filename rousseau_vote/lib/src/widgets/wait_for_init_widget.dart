
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/init/startup_initializer.dart';
import 'package:rousseau_vote/src/screens/splash_screen.dart';

class WaitForStartupInitWidget extends StatefulWidget {
  const WaitForStartupInitWidget({this.showAfterInit, this.startupInitializer});

  final StartupInitializer startupInitializer;
  final Widget showAfterInit;

  @override
  _WaitForStartupInitWidgetState createState() => _WaitForStartupInitWidgetState(showAfterInit, startupInitializer);
}

class _WaitForStartupInitWidgetState extends State<WaitForStartupInitWidget> {

  _WaitForStartupInitWidgetState(this._showAfterInit, this._startupInitializer);

  bool _isInitialized;
  final StartupInitializer _startupInitializer;
  final Widget _showAfterInit;

  @override
  Widget build(BuildContext context) {
    return _isInitialized ? _showAfterInit : SplashScreen();
  }

  @override
  void initState() {
    super.initState();
    _isInitialized = false;
    _startupInitializer.doInitialize().whenComplete(() {
      // TODO handle errors!?
      setState(() {
        _isInitialized = true;
      });
    });
  }
}