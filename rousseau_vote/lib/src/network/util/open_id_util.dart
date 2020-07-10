
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:uuid/uuid.dart';

String generateRegisterUrl() {
  final String nonce = generateNonce();
  final String state = generateState();
  return '$KEYCLOAK_REGISTRATION_URL&nonce=$nonce&state=$state';
}

String generateNonce() {
  return Uuid().v4();
}

String generateState() {
  return Uuid().v4();
}


