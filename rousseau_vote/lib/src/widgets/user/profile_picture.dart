
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {

  const ProfilePicture(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage:  CachedNetworkImageProvider(url),
    );
  }

}