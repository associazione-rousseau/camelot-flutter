
class LoginException implements Exception {
  final String message;

  LoginException([this.message = ""]);

  String toString() => "LoginException: $message";
}