
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {

  const ProfilePicture(this.uri);

  final String uri;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage:  _imageProvider(uri),
    );
  }

  ImageProvider _imageProvider(String uri) {
    return uri.startsWith('http') ?
      CachedNetworkImageProvider(uri) :
      AssetImage(uri);
  }
}
