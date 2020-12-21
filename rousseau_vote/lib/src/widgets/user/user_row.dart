
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/user/profile_picture.dart';

class UserRow extends StatelessWidget {

  const UserRow({ @required this.user });

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: openProfileAction(context, user.slug),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        leading: ProfilePicture(url: user.getProfilePictureUrl(), radius: 15,),
        title: Text(user.fullName),
      ),
    );
  }

}