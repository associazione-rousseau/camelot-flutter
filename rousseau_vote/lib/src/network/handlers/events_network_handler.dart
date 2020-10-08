
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/events/event_list.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/network/restclients/events_rest_client.dart';

@singleton
class EventsNetworkHandler {

  EventsNetworkHandler(Dio dio) : _client = EventsRestClient(dio);

  final List<EventList> _eventList = <EventList>[];
  final EventsRestClient _client;

  bool get hasEvents => eventList.isNotEmpty;

  List<EventList> get eventList => _eventList;

  Future<List<EventList>> fetchEvents() async {
    final CurrentUser currentUser = await getIt<UserNetworkHandler>().fetchCurrentUser(fetchPolicy: FetchPolicy.cacheFirst);
    final List<EventList> events = await _client.getEventList(currentUser.regione.eventsCode);
    if (events == null) {
      return _eventList;
    }
    _eventList.clear();
    _eventList.addAll(events);
    return _eventList;
  }
}