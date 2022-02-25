import 'dart:convert';

ResponseStoriesHome responseStoriesFromJson(String str) => ResponseStoriesHome.fromJson(json.decode(str));

String responseStoriesToJson(ResponseStoriesHome data) => json.encode(data.toJson());

class ResponseStoriesHome {

    ResponseStoriesHome({
        required this.resp,
        required this.message,
        required this.stories,
    });

    bool resp;
    String message;
    List<StoryHome> stories;

    factory ResponseStoriesHome.fromJson(Map<String, dynamic> json) => ResponseStoriesHome(
        resp: json["resp"],
        message: json["message"],
        stories: List<StoryHome>.from(json["stories"].map((x) => StoryHome.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
    };
}

class StoryHome {

    StoryHome({
        required this.uidStory,
        required this.username,
        required this.avatar,
        required this.countStory
    });

    String uidStory;
    String username;
    String avatar;
    int countStory;

    factory StoryHome.fromJson(Map<String, dynamic> json) => StoryHome(
        uidStory: json["uid_story"],
        username: json["username"],
        avatar: json["avatar"],
        countStory: json["count_story"],
    );

    Map<String, dynamic> toJson() => {
        "uid_story": uidStory,
        "username": username,
        "avatar": avatar,
        "count_story": countStory
    };
}
