import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/activist/badge_search_widget.dart';

import 'name_search_widget.dart';

class ActivistSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          NameSearchWidget(),
          const VerticalSpace(15),
          BadgeSearchWidget(),
        ],
      ),
    );
  }
}
