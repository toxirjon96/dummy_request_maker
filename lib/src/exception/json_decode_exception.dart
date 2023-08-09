class JsonDecodeException implements Exception {
  final String _message;

  const JsonDecodeException(String message) : _message = message;

  String get message => _message;
}
