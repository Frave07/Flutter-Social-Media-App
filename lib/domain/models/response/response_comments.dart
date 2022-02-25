import 'dart:convert';

ResponseComments responseCommentsFromJson(String str) => ResponseComments.fromJson(json.decode(str));

String responseCommentsToJson(ResponseComments data) => json.encode(data.toJson());

class ResponseComments {

    ResponseComments({
        required this.resp,
        required this.message,
        required this.comments,
    });

    bool resp;
    String message;
    List<Comment> comments;

    factory ResponseComments.fromJson(Map<String, dynamic> json) => ResponseComments(
        resp: json["resp"],
        message: json["message"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {

    Comment({
        required this.uid,
        required this.comment,
        required this.isLike,
        required this.createdAt,
        required this.personUid,
        required this.postUid,
        required this.username,
        required this.avatar,
    });

    String uid;
    String comment;
    int isLike;
    DateTime createdAt;
    String personUid;
    String postUid;
    String username;
    String avatar;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        uid: json["uid"],
        comment: json["comment"],
        isLike: json["is_like"],
        createdAt: DateTime.parse(json["created_at"]),
        personUid: json["person_uid"],
        postUid: json["post_uid"],
        username: json["username"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "comment": comment,
        "is_like": isLike,
        "created_at": createdAt.toIso8601String(),
        "person_uid": personUid,
        "post_uid": postUid,
        "username": username,
        "avatar": avatar,
    };
}
