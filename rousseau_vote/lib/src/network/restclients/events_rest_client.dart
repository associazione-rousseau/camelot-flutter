import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/events/event.dart';
import 'package:rousseau_vote/src/models/events/event_list.dart';

part 'events_rest_client.g.dart';

@RestApi(baseUrl: EVENT_PORTAL_URL)
abstract class EventsRestClient {
  factory EventsRestClient(Dio dio) = _EventsRestClient;

  @GET('/wp-json/app/events_feed')
  Future<List<EventList>> getEventList(@Query('region') String region);
}
