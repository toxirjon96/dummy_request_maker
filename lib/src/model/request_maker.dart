import 'package:dummy_request_maker/dummy_request_maker_library.dart';
import 'package:http/http.dart';

class RequestMaker<T> {
  late final String _baseUrl;
  late final T? Function(Map<String, Object?> json) _convert;
  late final List<T>? Function(Map<String, Object?> json) _convertList;

  RequestMaker(
    String baseUrl, {
    required T? Function(Map<String, Object?> json) convert,
    required List<T>? Function(Map<String, Object?> json) convertList,
  }) {
    this.baseUrl = baseUrl;
    _convert = convert;
    _convertList = convertList;
  }

  set baseUrl(String baseUrl) {
    try {
      _checkUrl(baseUrl);
      _baseUrl = baseUrl;
    } on HttpUrlException {
      rethrow;
    }
  }

  String get baseUrl => _baseUrl;

  T? Function(Map<String, Object?> json)? get convert => _convert;

  Function(Map<String, Object?> json) get convertList => _convertList;

  Future<T?> getRequestById(String subUrl,
      {Map<String, String>? headers}) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await get(
        Uri.parse(url),
        headers: headers,
      );
      _statusCodeException(response, 200);
      return _getObject(response.body);
    } on HttpUrlException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Future<List<T?>?> getRequest(String subUrl,
      {Map<String, String>? headers}) async {
    try {
      String url = "$baseUrl$subUrl";
      _checkUrl(url);
      Response response = await get(
        Uri.parse(url),
        headers: headers,
      );
      _statusCodeException(response, 200);
      return _getElements(response.body);
    } on HttpUrlException {
      rethrow;
    } on JsonDecodeException {
      rethrow;
    } on HttpStatusCodeException {
      rethrow;
    } catch (e) {
      throw HttpRequstException(e.toString());
    }
  }

  Map<String, Object?> _jsonMap(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      throw JsonDecodeException("This is not valid format of json.");
    }
  }

  List<T?>? _getElements(String jsonString) {
    try {
      Map<String, Object?> jsonMap = _jsonMap(jsonString);
      return convertList(jsonMap);
    } on JsonDecodeException {
      rethrow;
    }
  }

  T? _getObject(String jsonString) {
    try {
      Map<String, Object?>? jsonMap = _jsonMap(jsonString);
      return convert!(jsonMap);
    } on JsonDecodeException {
      rethrow;
    }
  }

  void _checkUrl(String url) {
    try {
      Uri.parse(url);
    } catch (e) {
      throw HttpUrlException("This is not valid url.");
    }
  }

  void _statusCodeException(Response response, int statuscode) {
    if (response.statusCode != statuscode) {
      throw HttpStatusCodeException("Request returns ${response.statusCode}.");
    }
  }
}
