
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/util/profile_util.dart';

class BadgeImage extends StatelessWidget {
  const BadgeImage({ @required this.badgeNumber, this.active = true, this.size, this.onTap });

  final int badgeNumber;
  final bool active;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        badgeAsset(badgeNumber, active),
        width: size,
      ),
      onTap: onTap,
    );
  }
}
