class HttpRequstException implements Exception {
  final String _message;

  const HttpRequstException(String message) : _message = message;

  String get message => _message;
}
