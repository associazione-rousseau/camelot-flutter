import 'package:flutter/cupertino.dart';

class VerticalScrollView extends StatelessWidget {
  final List<Widget> children;

  const VerticalScrollView({this.children = const <Widget>[]});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 500,
            ),
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children)))));
  }
}
