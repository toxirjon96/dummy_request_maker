class Posts {
  int? id;
  String? title;
  String? body;
  int? userId;
  List<String>? tags;
  int? reactions;

  Posts({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });

  factory Posts.fromJson(Map<String, Object?> json) {
    return Posts(
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
      userId: json["userId"] as int,
      tags: getElements(json["tags"] as List<Object?>),
      reactions: json["reactions"] as int,
    );
  }

  static Posts? Function(Map<String, Object?> map) convert() =>
      (Map<String, Object?> map) {
        return Posts.fromJson(map);
      };

  static List<Posts>? Function(Map<String, Object?> map) convertList() =>
      (Map<String, Object?> map) {
        List<Posts>? postList = [];
        List<Object?> list = map["posts"] as List<Object?>;

        postList = list
            .map((e) {
              if (e is Map<String, Object?>) {
                return convert()(e);
              }
            })
            .cast<Posts>()
            .toList();
        return postList;
      };

  static List<G> getElements<G>(List<Object?> list) {
    List<G> elements = [];
    for (Object? a in list) {
      if (a != null) {
        if (a is G) {
          elements.add(a as G);
        }
      }
    }
    return elements;
  }

  @override
  int get hashCode => Object.hash(title, body, userId, tags, reactions);

  @override
  bool operator ==(Object other) =>
      other is Posts &&
      other.title == title &&
      other.body == body &&
      other.userId == userId &&
      other.tags == tags &&
      other.reactions == reactions;

  @override
  String toString() {
    return "$runtimeType{id: $id, title: $title, body: $body,"
        "userId: $userId, tags: $tags, reactions: $reactions}";
  }
}
