import 'package:dummy_request_maker/dummy_request_maker_library.dart';

class DummyRequestMakerLogic {
  const DummyRequestMakerLogic();

  void call() {
    String baseUrl = "https://dummyjson.com";
    makeRequestForPosts(baseUrl);
  }

  void makeRequestForPosts(String baseUrl) async {
    try {
      RequestMaker request = RequestMaker<Posts>(
        baseUrl,
        convert: Posts.convert(),
        convertList: Posts.convertList(),
      );

      ///get posts by id
      print(await request.getById("/posts/1"));

      ///get all posts
      print(await request.get("/posts"));

      ///delete by posts id
      print(await request.delete("/posts/1"));

      ///update by posts id
      print(
        await request.put(
          "/posts/1",
          body: jsonEncode({
            "body": "body changed",
          }),
        ),
      );

      ///add posts
      print(
        await request.post(
          "/posts",
          body: jsonEncode(<String, Object?>{
            "title": "title1",
            "body": "body1",
            "userId": 9,
            "tags": [
              "tag1",
              "tag2",
              "tag3",
            ],
            "reactions": 3,
          }),
        ),
      );
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
