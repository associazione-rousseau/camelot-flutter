
class LoginException implements Exception {

  LoginException([this.message = '']);

  final String message;

  @override
  String toString() => 'LoginException: $message';
}