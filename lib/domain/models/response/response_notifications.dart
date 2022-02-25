import 'dart:convert';

ResponseNotifications responseNotificationsFromJson(String str) => ResponseNotifications.fromJson(json.decode(str));

String responseNotificationsToJson(ResponseNotifications data) => json.encode(data.toJson());

class ResponseNotifications {

    ResponseNotifications({
        required this.resp,
        required this.message,
        required this.notificationsdb,
    });

    bool resp;
    String message;
    List<Notificationsdb> notificationsdb;

    factory ResponseNotifications.fromJson(Map<String, dynamic> json) => ResponseNotifications(
        resp: json["resp"],
        message: json["message"],
        notificationsdb: List<Notificationsdb>.from(json["notificationsdb"].map((x) => Notificationsdb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "notificationsdb": List<dynamic>.from(notificationsdb.map((x) => x.toJson())),
    };
}

class Notificationsdb {

    Notificationsdb({
        required this.uidNotification,
        required this.typeNotification,
        required this.createdAt,
        required this.userUid,
        required this.username,
        required this.followersUid,
        required this.follower,
        required this.avatar,
        required this.postUid,
    });

    String uidNotification;
    String typeNotification;
    DateTime createdAt;
    String userUid;
    String username;
    String followersUid;
    String follower;
    String avatar;
    String postUid;

    factory Notificationsdb.fromJson(Map<String, dynamic> json) => Notificationsdb(
        uidNotification: json["uid_notification"],
        typeNotification: json["type_notification"],
        createdAt: DateTime.parse(json["created_at"]),
        userUid: json["user_uid"],
        username: json["username"],
        followersUid: json["followers_uid"],
        follower: json["follower"],
        avatar: json["avatar"],
        postUid: json["post_uid"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "uid_notification": uidNotification,
        "type_notification": typeNotification,
        "created_at": createdAt.toIso8601String(),
        "user_uid": userUid,
        "username": username,
        "followers_uid": followersUid,
        "follower": follower,
        "avatar": avatar,
        "post_uid": postUid,
    };
}
