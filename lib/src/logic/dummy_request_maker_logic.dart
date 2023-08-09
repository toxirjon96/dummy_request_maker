import 'package:dummy_request_maker/dummy_request_maker_library.dart';

class DummyRequestMakerLogic {
  const DummyRequestMakerLogic();

  void call() {
    String baseUrl = "https://dummyjson.com";
    makeRequestForPosts(baseUrl);
  }

  void makeRequestForPosts(String baseUrl) async {
    try {
      RequestMaker request = RequestMaker(
        baseUrl,
        convert: Posts.convert(),
        convertList: Posts.convertList(),
      );

      print(await request.getById("/posts/1"));
      print(await request.get("/posts"));
    } on HttpUrlException catch (e) {
      print(e.message);
    } on JsonDecodeException catch (e) {
      print(e.message);
    } on HttpStatusCodeException catch (e) {
      print(e.message);
    } on HttpRequstException catch (e) {
      print(e.message);
    }
  }
}
