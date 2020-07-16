
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String PROFILE_PICTURE_PLACEHOLDER = 'assets/images/profilePlaceholder.png';

class ProfilePicture extends StatelessWidget {

  const ProfilePicture({ this.url, this.radius = 30 });

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage:  _imageProvider(url),
      radius: radius,
    );
  }

  ImageProvider _imageProvider(String url) {
    return url == null ? const AssetImage(PROFILE_PICTURE_PLACEHOLDER) : CachedNetworkImageProvider(url);
  }
}
