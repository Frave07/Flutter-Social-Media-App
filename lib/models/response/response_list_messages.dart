import 'dart:convert';

ResponseListMessages responseListMessagesFromJson(String str) => ResponseListMessages.fromJson(json.decode(str));

String responseListMessagesToJson(ResponseListMessages data) => json.encode(data.toJson());

class ResponseListMessages {

    ResponseListMessages({
        required this.resp,
        required this.message,
        required this.listMessage,
    });

    bool resp;
    String message;
    List<ListMessage> listMessage;

    factory ResponseListMessages.fromJson(Map<String, dynamic> json) => ResponseListMessages(
        resp: json["resp"],
        message: json["message"],
        listMessage: List<ListMessage>.from(json["listMessage"].map((x) => ListMessage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "listMessage": List<dynamic>.from(listMessage.map((x) => x.toJson())),
    };
}

class ListMessage {

    ListMessage({
        required this.uidMessages,
        required this.sourceUid,
        required this.targetUid,
        required this.message,
        required this.createdAt,
    });

    String uidMessages;
    String sourceUid;
    String targetUid;
    String message;
    DateTime createdAt;

    factory ListMessage.fromJson(Map<String, dynamic> json) => ListMessage(
        uidMessages: json["uid_messages"],
        sourceUid: json["source_uid"],
        targetUid: json["target_uid"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "uid_messages": uidMessages,
        "source_uid": sourceUid,
        "target_uid": targetUid,
        "message": message,
        "created_at": createdAt.toIso8601String(),
    };
}
