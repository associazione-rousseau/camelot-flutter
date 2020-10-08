// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EventsRestClient implements EventsRestClient {
  _EventsRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://partecipa.ilblogdellestelle.it';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<EventList>> getEventList(region) async {
    ArgumentError.checkNotNull(region, 'region');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'region': region};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/wp-json/app/events_feed',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => EventList.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
