
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RousseauSliverAppBar extends StatelessWidget {

  const RousseauSliverAppBar({this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NestedScrollView(
      headerSliverBuilder:
          (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          const SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Image(
                  image: AssetImage('assets/images/rousseau_white.png'),
                  width: 200,
                ),
              ),
              centerTitle: true,
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