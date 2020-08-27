
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/widgets/events/event_picture_placeholder.dart';

class EventCard extends StatelessWidget {

  const EventCard({ @required this.event });

  final Event event;

  static const double RADIUS = 15.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      child: InkWell(
        onTap: openEvent,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(RADIUS)),
                child: CachedNetworkImage(
                  imageUrl: event.image,
                  placeholder: (BuildContext context, String url) =>
                      EventPicturePlaceholder(),
                  errorWidget:
                      (BuildContext context, String url, dynamic error) =>
                          EventPicturePlaceholder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
                child: Row(
                  children: [
                    Text(event.place.formattedAddress.toUpperCase()),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 15.0, right: 15.0),
                title: Text(
                  event.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Roboto '),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 15.0, bottom: 15.00, right: 15.0),
                title: Text(
                  "Domani dalle 20",
                  maxLines: 3,
                  style: const TextStyle(fontSize: 15, fontFamily: 'Roboto '),
                ),
              ),
            ]),
      ),
    );
  }

  void openEvent() {

  }

}