
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/arguments/event_details_arguments.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/models/events/event_date.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/horizontal_space.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
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
      floatingActionButton: ConditionalWidget(condition: arguments.event.canSignup, child: _fab(context)),
      extendedAppBar: _header(),
      backgroundColor: Colors.white,
      body: _body(context),
      actions: [WebMenuButton(url: arguments.event.permalink)],
    );
  }

  Widget _fab(BuildContext context) {
    return FittedBox(
        child: FloatingActionButton.extended(
          label:
          Text(RousseauLocalizations.getText(context, 'event-partecipate-button')),
          icon: const Icon(MdiIcons.calendarPlus),
          onPressed: openUrlExternalAction(context, arguments.event.signupUrl),
        ));
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

  Widget _body(BuildContext context) {
    return Card(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(
                  arguments.event.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Roboto '),
                ),
                subtitle: Text(arguments.event.subtitle),
              ),
              const VerticalSpace(10),
              _infoRow(MdiIcons.mapMarkerOutline, Text(arguments.event.location)),
              _infoRow(MdiIcons.clockOutline, _timeSection(context)),
              const VerticalSpace(10),
              Html(data: arguments.event.description, onLinkTap: (String url) => openUrlExternal(context, url),),
            ]),
      );
  }

  Widget _infoRow(IconData iconData, Widget info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 20, color: PRIMARY_RED,),
          const HorizontalSpace(5),
          info,
        ],
      ),
    );
  }

  Widget _timeSection(BuildContext context) {
    final List<Widget> times = <Widget>[];
    for(EventDate date in arguments.event.dates) {
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