import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RousseauSheetWidget extends StatelessWidget {
  const RousseauSheetWidget({@required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.75,
          maxChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: Container(
                color: Colors.white,
                child: child,
              ),
            );
          }),
    );
  }
}
