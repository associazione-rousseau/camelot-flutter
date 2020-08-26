
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/models/events/events_list_response.dart';
import 'package:rousseau_vote/src/network/restclients/events_rest_client.dart';

@singleton
class EventsNetworkHandler {

  EventsNetworkHandler(Dio dio) : _client = EventsRestClient(dio);

  final List<Event> _events = <Event>[];
  final EventsRestClient _client;

  bool get hasEvents => events.isNotEmpty;

  List<Event> get events => _events;

  Future<List<Event>> fetchEvents(String region) async {
    final List<Event> events = await _client.getEventList(region);
    if (events == null) {
      return _events;
    }
    _events.clear();
    _events.addAll(events);
    return _events;
  }
}