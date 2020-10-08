
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/models/events/event_list.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/events/event_card.dart';

class EventListSection extends StatelessWidget {


  const EventListSection({@required this.eventList});

  final EventList eventList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _label(eventList.label),
          const VerticalSpace(10),
          eventList.hasEvents ? _events() : _noEventsPlaceholder(context),
        ],
      ),
    );
  }

  Widget _label(String label) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(label, style: const TextStyle(fontSize: 20, color: PRIMARY_RED),),
    );
  }

  Widget _events() {
    final List<Widget> eventWidgets = <Widget>[];
    for(Event event in eventList.events) {
      eventWidgets.add(EventCard(event: event));
      eventWidgets.add(const VerticalSpace(20));
    }
    return Column(
      children: eventWidgets,
    );
  }

  Widget _noEventsPlaceholder(BuildContext context) {
    final String text = RousseauLocalizations.getText(context, 'no-events-message');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(text, style: const TextStyle(fontSize: 15),),
    );
  }
}