import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child:
          Card(
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15),
                  child: child))
        );
  }
}
