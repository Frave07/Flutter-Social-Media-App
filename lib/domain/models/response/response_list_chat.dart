import 'dart:convert';

ResponseListChat responseListChatFromJson(String str) => ResponseListChat.fromJson(json.decode(str));

String responseListChatToJson(ResponseListChat data) => json.encode(data.toJson());

class ResponseListChat {

    ResponseListChat({
        required this.resp,
        required this.message,
        required this.listChat,
    });

    bool resp;
    String message;
    List<ListChat> listChat;

    factory ResponseListChat.fromJson(Map<String, dynamic> json) => ResponseListChat(
        resp: json["resp"],
        message: json["message"],
        listChat: List<ListChat>.from(json["listChat"].map((x) => ListChat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "listChat": List<dynamic>.from(listChat.map((x) => x.toJson())),
    };
}

class ListChat {

    ListChat({
        required this.uidListChat,
        required this.sourceUid,
        required this.targetUid,
        required this.lastMessage,
        required this.updatedAt,
        required this.username,
        required this.avatar,
    });

    String uidListChat;
    String sourceUid;
    String targetUid;
    String lastMessage;
    DateTime updatedAt;
    String username;
    String avatar;

    factory ListChat.fromJson(Map<String, dynamic> json) => ListChat(
        uidListChat: json["uid_list_chat"],
        sourceUid: json["source_uid"],
        targetUid: json["target_uid"],
        lastMessage: json["last_message"],
        updatedAt: DateTime.parse(json["updated_at"]),
        username: json["username"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "uid_list_chat": uidListChat,
        "source_uid": sourceUid,
        "target_uid": targetUid,
        "last_message": lastMessage,
        "updated_at": updatedAt.toIso8601String(),
        "username": username,
        "avatar": avatar,
    };
}
