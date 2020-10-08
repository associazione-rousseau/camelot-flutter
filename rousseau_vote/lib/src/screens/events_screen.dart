
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/events/event_list.dart';
import 'package:rousseau_vote/src/network/handlers/events_network_handler.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/core/icon_text_screen.dart';
import 'package:rousseau_vote/src/widgets/events/event_card.dart';
import 'package:rousseau_vote/src/widgets/events/event_list_section.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';

class EventsScreen extends StatefulWidget {

  const EventsScreen();

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {

  final EventsNetworkHandler _eventsNetworkHandler = getIt<EventsNetworkHandler>();
  bool _isLoading;
  bool _hasErrors;

  @override
  void initState() {
    super.initState();
    _hasErrors = false;
    if(_eventsNetworkHandler.hasEvents) {
      _isLoading = false;
    } else {
      _isLoading = true;
      fetchEvents().then((List<EventList> eventList) {
        setState(() {
          _isLoading = false;
          _hasErrors = false;
        });
      }).catchError((Object onError) {
        print(onError);
        setState(() {
          _isLoading = false;
          _hasErrors = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading) {
      return const LoadingIndicator();
    }
    if(_hasErrors) {
      return const IconTextScreen(iconData: MdiIcons.calendar, messageKey: 'no-events',);;
    }
    return RefreshIndicator(
      onRefresh: _onPullToRefresh,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: _eventsNetworkHandler.eventList.length,
          separatorBuilder: (BuildContext context, int index) => const VerticalSpace(20),
            itemBuilder: (BuildContext context, int index) {
              return EventListSection(eventList: _eventsNetworkHandler.eventList[index]);
            }
        ),
      ),
    );
  }

  Future<List<EventList>> _onPullToRefresh() async {
    final List<EventList> eventList = await fetchEvents();
    setState(() {
      _isLoading = false;
      _hasErrors = false;
    });
    return eventList;
  }

  Future<List<EventList>> fetchEvents() {
    return _eventsNetworkHandler.fetchEvents();
  }
}
