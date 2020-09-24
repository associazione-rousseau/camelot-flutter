
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rousseau_vote/src/models/arguments/event_details_arguments.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/widgets/events/event_picture_placeholder.dart';
import 'package:rousseau_vote/src/widgets/menu/web_menu_button.dart';
import 'package:rousseau_vote/src/widgets/rousseau_animated_screen.dart';

class EventDetailsScreen extends StatelessWidget {

  const EventDetailsScreen({ @required this.arguments });

  static const String ROUTE_NAME = '/event_details';

  final EventDetailsArgument arguments;

  @override
  Widget build(BuildContext context) {
    return RousseauAnimatedScreen(
      appBar: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(),
      ),
      extendedAppBar: _header(),
      backgroundColor: Colors.white,
      body: _body(),
      actions: [WebMenuButton(url: arguments.event.permalink)],
    );
  }

  Widget _header() {
    return CachedNetworkImage(
      imageUrl: arguments.event.coverImage,
      placeholder: (BuildContext context, String url) =>
          EventPicturePlaceholder(),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          EventPicturePlaceholder(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Html(data: arguments.event.description),
      ],
    );
  }

}