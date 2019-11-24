import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/network/response/credentials_login_response.dart';
import 'package:rousseau_vote/src/network/response/init_login_response.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';

part 'login_rest_client.g.dart';

@RestApi(baseUrl: "$KEYCLOAK_URL/auth/realms/rousseau")
abstract class LoginRestClient {
  factory LoginRestClient(Dio dio) = _LoginRestClient;

  @GET("/protocol/openid-connect/auth")
  Future<InitLoginResponse> initLogin(
      @Query('nonce') String nonce, @Query('state') String state,
      {@Query('client_id') String clientId = KEYCLOAK_CLIENT_ID,
      @Query('redirect_uri') String redirectUri = KEYCLOAK_REDIRECT_URI,
      @Query('response_mode') String responseMode = 'fragment',
      @Query('response_type') String responseType = 'code',
      @Query('scope') String scope = 'openid email profile'});

  @POST('/login-actions/authenticate')
  @FormUrlEncoded()
  Future<CredentialsLoginResponse> login(
      @Query('session_code') String sessionCode,
      @Query('execution') String execution,
      @Query('tab_id') String tabId,
      @Body() Map<String, String> body,
      {@Query('client_id') String clientId = KEYCLOAK_CLIENT_ID});

  @POST('/login-actions/authenticate')
  @FormUrlEncoded()
  Future<CredentialsLoginResponse> submitTwoFactorCode(
      @Query('session_code') String sessionCode,
      @Query('execution') String execution,
      @Query('tab_id') String tabId,
      @Body() Map<String, String> body,
      {@Query('client_id') String clientId = KEYCLOAK_CLIENT_ID});

  @POST('/protocol/openid-connect/token')
  @FormUrlEncoded()
  Future<TokenResponse> getToken(@Body() Map<String, String> body);
}
