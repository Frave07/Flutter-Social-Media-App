import 'dart:convert';

ResponseUser responseUserFromJson(String str) => ResponseUser.fromJson(json.decode(str));

String responseUserToJson(ResponseUser data) => json.encode(data.toJson());

class ResponseUser {

    bool resp;
    String message;
    User user;
    PostsUser postsUser;

    ResponseUser({
        required this.resp,
        required this.message,
        required this.user,
        required this.postsUser,
    });

    factory ResponseUser.fromJson(Map<String, dynamic> json) => ResponseUser(
        resp: json["resp"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        postsUser: PostsUser.fromJson(json["posts"]),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "user": user.toJson(),
        "posts": postsUser.toJson(),
    };
}

class PostsUser {

    int posters;
    int friends;
    int followers;

    PostsUser({
        required this.posters,
        required this.friends,
        required this.followers,
    });

    factory PostsUser.fromJson(Map<String, dynamic> json) => PostsUser(
        posters: json["posters"] ?? -0,
        friends: json["friends"] ?? -0,
        followers: json["followers"] ?? -0,
    );

    Map<String, dynamic> toJson() => {
        "posters": posters,
        "friends": friends,
        "followers": followers,
    };
}

class User {

    String uid;
    String fullname;
    String phone;
    String image;
    String cover;
    DateTime birthdayDate;
    DateTime createdAt;
    String username;
    String description;
    int isPrivate;
    int isOnline;
    String email;

    User({
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
        required this.isOnline,
        required this.email,
    });
    

    factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"] ?? '',
        fullname: json["fullname"] ?? '',
        phone: json["phone"] ?? '',
        image: json["image"] ?? '',
        cover: json["cover"] ?? '',
        birthdayDate: DateTime.parse(json["birthday_date"] ?? '2021-10-22T20:17:53'),
        createdAt: DateTime.parse(json["created_at"] ?? '2021-10-22T20:17:53'),
        username: json["username"] ?? '',
        description: json["description"] ?? '',
        isPrivate: json["is_private"] ?? -0,
        isOnline: json["is_online"] ?? -0,
        email: json["email"] ?? '',
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
        "is_online": isOnline,
        "email": email,
    };
}
