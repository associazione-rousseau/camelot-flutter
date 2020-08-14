import 'package:rousseau_vote/src/network/handlers/login_network_handler.dart';
import 'package:rousseau_vote/src/network/response/token_response.dart';

class CredentialsLoginResult {

  const CredentialsLoginResult({ this.loginSession, this.tokenResponse});

  final LoginSession loginSession;
  final TokenResponse tokenResponse;
}
