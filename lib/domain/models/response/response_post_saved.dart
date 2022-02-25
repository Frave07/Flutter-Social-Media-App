import 'dart:convert';

ResponsePostSaved responsePostSavedFromJson(String str) => ResponsePostSaved.fromJson(json.decode(str));

String responsePostSavedToJson(ResponsePostSaved data) => json.encode(data.toJson());

class ResponsePostSaved {

    ResponsePostSaved({
        required this.resp,
        required this.message,
        required this.listSavedPost,
    });

    bool resp;
    String message;
    List<ListSavedPost> listSavedPost;

    factory ResponsePostSaved.fromJson(Map<String, dynamic> json) => ResponsePostSaved(
        resp: json["resp"],
        message: json["message"],
        listSavedPost: List<ListSavedPost>.from(json["listSavedPost"].map((x) => ListSavedPost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "listSavedPost": List<dynamic>.from(listSavedPost.map((x) => x.toJson())),
    };
}

class ListSavedPost {
  
    ListSavedPost({
        required this.postSaveUid,
        required this.postUid,
        required this.personUid,
        required this.dateSave,
        required this.avatar,
        required this.username,
        required this.images,
    });

    String postSaveUid;
    String postUid;
    String personUid;
    DateTime dateSave;
    String avatar;
    String username;
    String images;

    factory ListSavedPost.fromJson(Map<String, dynamic> json) => ListSavedPost(
        postSaveUid: json["post_save_uid"],
        postUid: json["post_uid"],
        personUid: json["person_uid"],
        dateSave: DateTime.parse(json["date_save"]),
        avatar: json["avatar"],
        username: json["username"],
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "post_save_uid": postSaveUid,
        "post_uid": postUid,
        "person_uid": personUid,
        "date_save": dateSave.toIso8601String(),
        "avatar": avatar,
        "username": username,
        "images": images,
    };
}
