
import 'package:flutter/cupertino.dart';

/// Wrapper widget that returns the [child] if the [condition] is met.
/// Otherwise it returns an empty Container
class ConditionalWidget extends StatelessWidget {

  const ConditionalWidget({Key key, @required this.condition, @required this.child}) : super(key: key);

  final bool condition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return condition ? child : Container();
  }
}