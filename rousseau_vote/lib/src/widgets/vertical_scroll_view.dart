import 'package:flutter/cupertino.dart';

class VerticalScrollView extends StatelessWidget {

  const VerticalScrollView({this.children = const <Widget>[]});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 500,
            ),
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children)))));
  }
}
