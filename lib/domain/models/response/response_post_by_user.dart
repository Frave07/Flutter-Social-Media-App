import 'dart:convert';

ResponsePostByUser responsePostByUserFromJson(String str) => ResponsePostByUser.fromJson(json.decode(str));

String responsePostByUserToJson(ResponsePostByUser data) => json.encode(data.toJson());

class ResponsePostByUser {

    ResponsePostByUser({
        required this.resp,
        required this.message,
        required this.postUser,
    });

    bool resp;
    String message;
    List<PostUser> postUser;

    factory ResponsePostByUser.fromJson(Map<String, dynamic> json) => ResponsePostByUser(
        resp: json["resp"],
        message: json["message"],
        postUser: List<PostUser>.from(json["postUser"].map((x) => PostUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "postUser": List<dynamic>.from(postUser.map((x) => x.toJson())),
    };
}

class PostUser {

    PostUser({
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
        required this.isLike,
    });

    String postUid;
    int isComment;
    String typePrivacy;
    DateTime createdAt;
    String personUid;
    String username;
    String avatar;
    String images;
    int countComment;
    int countLikes;
    int isLike;

    factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        postUid: json["post_uid"],
        isComment: json["is_comment"],
        typePrivacy: json["type_privacy"],
        createdAt: DateTime.parse(json["created_at"]),
        personUid: json["person_uid"],
        username: json["username"],
        avatar: json["avatar"],
        images: json["images"],
        countComment: json["count_comment"],
        countLikes: json["count_likes"],
        isLike: json["is_like"],
    );

    Map<String, dynamic> toJson() => {
        "post_uid": postUid,
        "is_comment": isComment,
        "type_privacy": typePrivacy,
        "created_at": createdAt.toIso8601String(),
        "person_uid": personUid,
        "username": username,
        "avatar": avatar,
        "images": images,
        "count_comment": countComment,
        "count_likes": countLikes,
        "is_like": isLike,
    };
}
