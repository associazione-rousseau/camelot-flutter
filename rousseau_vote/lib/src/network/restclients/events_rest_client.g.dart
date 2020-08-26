// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EventsRestClient implements EventsRestClient {
  _EventsRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://partecipa.ilblogdellestelle.it';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getEventList(region) async {
    ArgumentError.checkNotNull(region, 'region');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'region': region};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/wp-json/app/iniziative',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Event.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
