import 'dart:convert';

ResponsePostProfile responsePostProfileFromJson(String str) => ResponsePostProfile.fromJson(json.decode(str));

String responsePostProfileToJson(ResponsePostProfile data) => json.encode(data.toJson());

class ResponsePostProfile {

    ResponsePostProfile({
        required this.resp,
        required this.message,
        required this.post,
    });

    bool resp;
    String message;
    List<PostProfile> post;

    factory ResponsePostProfile.fromJson(Map<String, dynamic> json) => ResponsePostProfile(
        resp: json["resp"],
        message: json["message"],
        post: List<PostProfile>.from(json["post"].map((x) => PostProfile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "post": List<dynamic>.from(post.map((x) => x.toJson())),
    };
}

class PostProfile {

    PostProfile({
        required this.uid,
        required this.isComment,
        required this.typePrivacy,
        required this.createdAt,
        required this.images,
    });

    String uid;
    int isComment;
    String typePrivacy;
    DateTime createdAt;
    String images;

    factory PostProfile.fromJson(Map<String, dynamic> json) => PostProfile(
        uid: json["uid"] ?? '',
        isComment: json["is_comment"] ?? -0,
        typePrivacy: json["type_privacy"] ?? '',
        createdAt: DateTime.parse(json["created_at"] ?? json['']),
        images: json["images"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "is_comment": isComment,
        "type_privacy": typePrivacy,
        "created_at": createdAt.toIso8601String(),
        "images": images,
    };
}
