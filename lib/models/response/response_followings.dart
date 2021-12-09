import 'dart:convert';

ResponseFollowings responseFollowingsFromJson(String str) => ResponseFollowings.fromJson(json.decode(str));

String responseFollowingsToJson(ResponseFollowings data) => json.encode(data.toJson());

class ResponseFollowings {

    ResponseFollowings({
        required this.resp,
        required this.message,
        required this.followings,
    });

    bool resp;
    String message;
    List<Following> followings;

    factory ResponseFollowings.fromJson(Map<String, dynamic> json) => ResponseFollowings(
        resp: json["resp"],
        message: json["message"],
        followings: List<Following>.from(json["followings"].map((x) => Following.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "followings": List<dynamic>.from(followings.map((x) => x.toJson())),
    };
}

class Following {

    Following({
        required this.uidFriend,
        required this.uidUser,
        required this.dateFriend,
        required this.username,
        required this.fullname,
        required this.avatar,
    });

    String uidFriend;
    String uidUser;
    DateTime dateFriend;
    String username;
    String fullname;
    String avatar;

    factory Following.fromJson(Map<String, dynamic> json) => Following(
        uidFriend: json["uid_friend"],
        uidUser: json["uid_user"],
        dateFriend: DateTime.parse(json["date_friend"]),
        username: json["username"],
        fullname: json["fullname"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "uid_friend": uidFriend,
        "uid_user": uidUser,
        "date_friend": dateFriend.toIso8601String(),
        "username": username,
        "fullname": fullname,
        "avatar": avatar,
    };
}
