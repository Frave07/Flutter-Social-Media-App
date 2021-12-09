import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social_media/helpers/secure_storage.dart';
import 'package:social_media/models/response/response_list_chat.dart';
import 'package:social_media/models/response/response_list_messages.dart';
import 'package:social_media/services/url_service.dart';

class ChatServices {


  Future<List<ListChat>> getListChatByUser() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.urlApi}/chat/get-list-chat-by-user'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );  

    return ResponseListChat.fromJson(jsonDecode(resp.body)).listChat;
  }


  Future<List<ListMessage>> listMessagesByUser(String uid) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.urlApi}/chat/get-all-message-by-user/'+ uid),
      headers: { 'Accept': 'application/json', 'xxx-token' : token! }
    );

    return ResponseListMessages.fromJson(jsonDecode(resp.body)).listMessage;
  }







}

final chatServices = ChatServices();