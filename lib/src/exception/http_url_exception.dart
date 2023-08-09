class HttpUrlException implements Exception {
  final String _message;

  const HttpUrlException(String message) : _message = message;

  String get message => _message;
}
