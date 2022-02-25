import 'dart:convert';

ResponseSearch responseSearchFromJson(String str) => ResponseSearch.fromJson(json.decode(str));

String responseSearchToJson(ResponseSearch data) => json.encode(data.toJson());

class ResponseSearch {

    ResponseSearch({
        required this.resp,
        required this.message,
        required this.userFind,
    });

    bool resp;
    String message;
    List<UserFind> userFind;

    factory ResponseSearch.fromJson(Map<String, dynamic> json) => ResponseSearch(
        resp: json["resp"],
        message: json["message"],
        userFind: List<UserFind>.from(json["userFind"].map((x) => UserFind.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "userFind": List<dynamic>.from(userFind.map((x) => x.toJson())),
    };
}

class UserFind {
  
    UserFind({
        required this.uid,
        required this.fullname,
        required this.avatar,
        required this.username,
    });

    String uid;
    String fullname;
    String avatar;
    String username;

    factory UserFind.fromJson(Map<String, dynamic> json) => UserFind(
        uid: json["uid"],
        fullname: json["fullname"],
        avatar: json["avatar"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "avatar": avatar,
        "username": username,
    };
}
