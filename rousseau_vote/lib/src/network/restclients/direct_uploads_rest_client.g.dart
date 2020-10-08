// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_uploads_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DirectUploadsRestClient implements DirectUploadsRestClient {
  _DirectUploadsRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.rousseau.movimento5stelle.it';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<DirectUploadsResponse> post(blob) async {
    ArgumentError.checkNotNull(blob, 'blob');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'blob': blob?.toJson()};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/files/direct_uploads',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = DirectUploadsResponse.fromJson(_result.data);
    return value;
  }
}
