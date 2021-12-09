import 'dart:convert';

ResponseUserSearch responseUserSearchFromJson(String str) => ResponseUserSearch.fromJson(json.decode(str));

String responseUserSearchToJson(ResponseUserSearch data) => json.encode(data.toJson());

class ResponseUserSearch {

    ResponseUserSearch({
        required this.resp,
        required this.message,
        required this.anotherUser,
        required this.analytics,
        required this.postsUser,
        required this.isFriend,
        required this.isPendingFollowers
    });

    bool resp;
    String message;
    AnotherUser anotherUser;
    Analytics analytics;
    List<PostsUser> postsUser;
    int isFriend;
    int isPendingFollowers;

    factory ResponseUserSearch.fromJson(Map<String, dynamic> json) => ResponseUserSearch(
        resp: json["resp"],
        message: json["message"],
        anotherUser: AnotherUser.fromJson(json["anotherUser"]),
        analytics: Analytics.fromJson(json["analytics"]),
        postsUser: List<PostsUser>.from(json["postsUser"].map((x) => PostsUser.fromJson(x))),
        isFriend: json["is_friend"],
        isPendingFollowers: json["isPendingFollowers"]
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "anotherUser": anotherUser.toJson(),
        "analytics": analytics.toJson(),
        "postsUser": List<dynamic>.from(postsUser.map((x) => x.toJson())),
        "is_friend": isFriend,
        "isPendingFollowers": isPendingFollowers
    };
}

class Analytics {
    Analytics({
        required this.posters,
        required this.friends,
        required this.followers,
    });

    int posters;
    int friends;
    int followers;

    factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        posters: json["posters"],
        friends: json["friends"],
        followers: json["followers"],
    );

    Map<String, dynamic> toJson() => {
        "posters": posters,
        "friends": friends,
        "followers": followers,
    };
}

class AnotherUser {
    AnotherUser({
        required this.uid,
        required this.fullname,
        required this.phone,
        required this.image,
        required this.cover,
        required this.birthdayDate,
        required this.createdAt,
        required this.username,
        required this.description,
        required this.isPrivate,
        required this.email,
    });

    String uid;
    String fullname;
    String phone;
    String image;
    String cover;
    dynamic birthdayDate;
    DateTime createdAt;
    String username;
    String description;
    int isPrivate;
    String email;

    factory AnotherUser.fromJson(Map<String, dynamic> json) => AnotherUser(
        uid: json["uid"],
        fullname: json["fullname"],
        phone: json["phone"] ?? '',
        image: json["image"] ?? '',
        cover: json["cover"] ?? '',
        birthdayDate: DateTime.parse(json["birthday_date"] ?? '2021-10-22T20:17:53'),
        createdAt: DateTime.parse(json["created_at"] ?? '2021-10-22T20:17:53'),
        username: json["username"],
        description: json["description"] ?? '',
        isPrivate: json["is_private"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "phone": phone,
        "image": image,
        "cover": cover,
        "birthday_date": birthdayDate,
        "created_at": createdAt.toIso8601String(),
        "username": username,
        "description": description,
        "is_private": isPrivate,
        "email": email,
    };
}

class PostsUser {

    PostsUser({
        required this.postUid,
        required this.isComment,
        required this.typePrivacy,
        required this.createdAt,
        required this.images
    });

    String postUid;
    int isComment;
    String typePrivacy;
    DateTime createdAt;
    String images;

    factory PostsUser.fromJson(Map<String, dynamic> json) => PostsUser(
        postUid: json["post_uid"],
        isComment: json["is_comment"],
        typePrivacy: json["type_privacy"],
        createdAt: DateTime.parse(json["created_at"]),
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "post_uid": postUid,
        "is_comment": isComment,
        "type_privacy": typePrivacy,
        "created_at": createdAt.toIso8601String(),
        "images": images,
    };
}
