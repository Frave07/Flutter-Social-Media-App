import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {

    bool resp;
    String message;
    String? token;

    ResponseLogin({
        required this.resp,
        required this.message,
        this.token,
    });

    factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        resp: json["resp"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "token": token,
    };
}
