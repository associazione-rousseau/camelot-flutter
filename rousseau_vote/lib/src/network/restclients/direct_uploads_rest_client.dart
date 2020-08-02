import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/network/request/direct_upload_request_blob.dart';
import 'package:rousseau_vote/src/network/response/direct_uploads_response.dart';

part 'direct_uploads_rest_client.g.dart';

@RestApi(baseUrl: '$API_URL_PRODUCTION')
abstract class DirectUploadsRestClient {
  factory DirectUploadsRestClient(Dio dio) = _DirectUploadsRestClient;

  @POST('/files/direct_uploads')
  @FormUrlEncoded()
  Future<DirectUploadsResponse> post(@Query('blob') DirectUploadRequestBlob blob);
}