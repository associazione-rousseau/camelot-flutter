import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/providers/vote_options_provider.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/profile/badges_widget.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';
import 'package:rousseau_vote/src/widgets/user/user_card.dart';

class CandidateOptionCard extends StatelessWidget {
  const CandidateOptionCard(this._option, this._selected);

  final Option _option;
  final bool _selected;

  static const double DEFAULT_SPACING = 30;
  static const double PROFILE_PICTURE_RADIUS = 30;

  @override
  Widget build(BuildContext context) {
    return UserCard(user: _option.entity, onTap: _onTap, selected: _selected,);
  }

  void _onTap(BuildContext context) {
    Provider.of<VoteOptionsProvider>(context, listen: false).onOptionSelected(context, _option);
  }
}
