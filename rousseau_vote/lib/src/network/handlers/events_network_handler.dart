
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/network/restclients/events_rest_client.dart';

@singleton
class EventsNetworkHandler {

  EventsNetworkHandler(Dio dio) : _client = EventsRestClient(dio);

  final List<Event> _events = <Event>[];
  final EventsRestClient _client;

  bool get hasEvents => events.isNotEmpty;

  List<Event> get events => _events;

  Future<List<Event>> fetchEvents() async {
    final CurrentUser currentUser = await getIt<UserNetworkHandler>().fetchCurrentUser(fetchPolicy: FetchPolicy.cacheFirst);
    final List<Event> events = await _client.getEventList(currentUser.regione.name.toLowerCase());
    if (events == null) {
      return _events;
    }
    _events.clear();
    _events.addAll(events);
    return _events;
  }
}