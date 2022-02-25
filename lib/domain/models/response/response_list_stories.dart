import 'dart:convert';

ResponseListStories responseListStoriesFromJson(String str) => ResponseListStories.fromJson(json.decode(str));

String responseListStoriesToJson(ResponseListStories data) => json.encode(data.toJson());

class ResponseListStories {

    ResponseListStories({
        required this.resp,
        required this.message,
        required this.listStories,
    });

    bool resp;
    String message;
    List<ListStory> listStories;

    factory ResponseListStories.fromJson(Map<String, dynamic> json) => ResponseListStories(
        resp: json["resp"],
        message: json["message"],
        listStories: List<ListStory>.from(json["listStories"].map((x) => ListStory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "listStories": List<dynamic>.from(listStories.map((x) => x.toJson())),
    };
}

class ListStory {

    ListStory({
        required this.uidMediaStory,
        required this.media,
        required this.createdAt,
        required this.storyUid,
    });

    String uidMediaStory;
    String media;
    DateTime createdAt;
    String storyUid;
    

    factory ListStory.fromJson(Map<String, dynamic> json) => ListStory(
        uidMediaStory: json["uid_media_story"],
        media: json["media"],
        createdAt: DateTime.parse(json["created_at"]),
        storyUid: json["story_uid"],
    );

    Map<String, dynamic> toJson() => {
        "uid_media_story": uidMediaStory,
        "media": media,
        "created_at": createdAt.toIso8601String(),
        "story_uid": storyUid,
        
    };
}
