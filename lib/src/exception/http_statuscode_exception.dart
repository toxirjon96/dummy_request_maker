class HttpStatusCodeException implements Exception {
  final String _message;

  const HttpStatusCodeException(String message) : _message = message;

  String get message => _message;
}
