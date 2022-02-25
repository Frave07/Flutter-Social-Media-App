import 'dart:convert';

ResponseFollowers responseFollowersFromJson(String str) => ResponseFollowers.fromJson(json.decode(str));

String responseFollowersToJson(ResponseFollowers data) => json.encode(data.toJson());

class ResponseFollowers {

    ResponseFollowers({
        required this.resp,
        required this.message,
        required this.followers,
    });

    bool resp;
    String message;
    List<Follower> followers;

    factory ResponseFollowers.fromJson(Map<String, dynamic> json) => ResponseFollowers(
        resp: json["resp"],
        message: json["message"],
        followers: List<Follower>.from(json["followers"].map((x) => Follower.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
    };
}

class Follower {

    Follower({
        required this.idFollower,
        required this.uidUser,
        required this.dateFollowers,
        required this.username,
        required this.fullname,
        required this.avatar,
    });

    String idFollower;
    String uidUser;
    DateTime dateFollowers;
    String username;
    String fullname;
    String avatar;

    factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        idFollower: json["idFollower"],
        uidUser: json["uid_user"],
        dateFollowers: DateTime.parse(json["date_followers"]),
        username: json["username"],
        fullname: json["fullname"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "idFollower": idFollower,
        "uid_user": uidUser,
        "date_followers": dateFollowers.toIso8601String(),
        "username": username,
        "fullname": fullname,
        "avatar": avatar,
    };
}
