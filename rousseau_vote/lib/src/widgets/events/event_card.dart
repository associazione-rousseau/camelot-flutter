
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/models/events/event.dart';

class EventCard extends StatelessWidget {

  const EventCard({ @required this.event });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Text(event.title);
  }

}