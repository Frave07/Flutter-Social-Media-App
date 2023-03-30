
class ResponsePost {
    
  final bool resp;
  final String message;
  final List<Post> posts;

  ResponsePost({
    required this.resp,
    required this.message,
    required this.posts,
  });

  factory ResponsePost.fromJson(Map<String, dynamic> json) => ResponsePost(
    resp: json["resp"],
    message: json["message"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );
}

class Post {

  final String postUid;
  final int isComment;
  final String typePrivacy;
  final DateTime createdAt;
  final String personUid;
  final String username;
  final String avatar;
  final String images;
  final int countComment;
  final int countLikes;
  final int isLike;

  Post({
    required this.postUid,
    required this.isComment,
    required this.typePrivacy,
    required this.createdAt,
    required this.personUid,
    required this.username,
    required this.avatar,
    required this.images,
    required this.countComment,
    required this.countLikes,
    required this.isLike
  });
    
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postUid: json["post_uid"],
    isComment: json["is_comment"],
    typePrivacy: json["type_privacy"],
    createdAt: DateTime.parse(json["created_at"]),
    personUid: json["person_uid"],
    username: json["username"],
    avatar: json["avatar"],
    images: json["images"],
    countComment: json["count_comment"] ?? -0,
    countLikes: json["count_likes"] ?? -0,
    isLike: json["is_like"] ?? -0
  );
}
