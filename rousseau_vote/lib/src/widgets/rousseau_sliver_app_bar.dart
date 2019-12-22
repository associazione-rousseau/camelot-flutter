
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RousseauSliverAppBar extends StatelessWidget {

  const RousseauSliverAppBar({this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder:
          (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          const SliverAppBar(
            pinned: true,
            title: Image(
              image: AssetImage('assets/images/rousseau_white.png'),
              height: 50,
            ),
          ),
        ];
      },
      body: Center(
        child: body,
      ),
    );
  }

}