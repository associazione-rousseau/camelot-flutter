import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/models/events/event_date.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/events/event_picture_placeholder.dart';

class EventCard extends StatelessWidget {
  const EventCard({@required this.event});

  final Event event;

  static const double RADIUS = 15.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      child: InkWell(
          onTap: openEventDetailsAction(context, event),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(RADIUS)),
                  child: CachedNetworkImage(
                    imageUrl: event.coverImage,
                    placeholder: (BuildContext context, String url) =>
                        EventPicturePlaceholder(),
                    errorWidget:
                        (BuildContext context, String url, dynamic error) =>
                            EventPicturePlaceholder(),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.location.toUpperCase()),
                        Text(
                          event.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Roboto '),
                        ),
                        _timeSection(context),
                      ],
                    )),
              ])),
    );
  }

  Widget _timeSection(BuildContext context) {
    final List<Widget> times = <Widget>[];
    for(EventDate date in event.dates) {
      final String dateString = formatDateDayMonth(context, date.timestamp);
      final String text = date.end != null && date.end.isNotEmpty ?
        RousseauLocalizations.getTextFormatted(context, 'event-date', [dateString, date.start, date.end]) :
        RousseauLocalizations.getTextFormatted(context, 'event-date-no-end', [dateString, date.start]);
      times.add(Text(text));
    }
    return Column(
      children: times,
    );
  }
}
