import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/helpers/debouncer.dart';
import 'package:social_media/data/storage/secure_storage.dart';
import 'package:social_media/domain/models/response/default_response.dart';
import 'package:social_media/domain/models/response/response_followers.dart';
import 'package:social_media/domain/models/response/response_followings.dart';
import 'package:social_media/domain/models/response/response_search.dart';
import 'package:social_media/domain/models/response/response_user.dart';
import 'package:social_media/domain/models/response/response_user_search.dart';


class UserServices {

  final debouncer = DeBouncer(duration: const Duration(milliseconds: 800));
  final StreamController<List<UserFind>> _streamController = StreamController<List<UserFind>>.broadcast(); 
  Stream<List<UserFind>> get searchProducts => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  Future<DefaultResponse> createdUser(String name, String user, String email, String password) async {

    final resp = await http.post(Uri.parse('${Environment.urlApi}/user'),
      headers: { 'Accept': 'application/json' },
      body: {
        'fullname' : name,
        'username' : user,
        'email': email,
        'password': password
      }
    );
    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<ResponseUser> getUserById() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-User-By-Id'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );

    return ResponseUser.fromJson(jsonDecode( resp.body ));
  }


  Future<DefaultResponse> verifyEmail(String email, String code) async {

    final resp = await http.get(Uri.parse('${Environment.urlApi}/user/verify-email/'+ code +'/' + email),
      headers: { 'Accept': 'application/json' }
    );

    return DefaultResponse.fromJson( jsonDecode( resp.body ));
  }


  Future<DefaultResponse> updatePictureCover( String cover ) async {

    final token = await secureStorage.readToken();

    var request = http.MultipartRequest('PUT', Uri.parse('${Environment.urlApi}/user/update-cover'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..files.add( await http.MultipartFile.fromPath('cover', cover));

    final resp = await request.send();
    var data = await http.Response.fromStream( resp );

    return DefaultResponse.fromJson( jsonDecode( data.body ));
  }

  
  Future<DefaultResponse> updatePictureProfile( String profile ) async {

    final token = await secureStorage.readToken();

    var request = http.MultipartRequest('PUT', Uri.parse('${Environment.urlApi}/user/update-image-profile'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..files.add( await http.MultipartFile.fromPath('profile', profile));

    final resp = await request.send();
    var data = await http.Response.fromStream( resp );

    return DefaultResponse.fromJson( jsonDecode( data.body ));

  }


  Future<DefaultResponse> updateProfile(String user, String description, String fullname, String phone) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${Environment.urlApi}/user/update-data-profile'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
      body: {
        'user': user,
        'description': description,
        'fullname': fullname,
        'phone': phone
      }
    );

    return DefaultResponse.fromJson( jsonDecode( resp.body ) ); 
  }


  Future<DefaultResponse> changePassword(String currentPass, String newPass ) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${Environment.urlApi}/user/change-password'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
      body: {
        'currentPassword' : currentPass,
        'newPassword': newPass
      }
    );

    return DefaultResponse.fromJson( jsonDecode( resp.body ) );
  }


  Future<DefaultResponse> changeAccountPrivacy() async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${Environment.urlApi}/user/change-account-privacy'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );

    return DefaultResponse.fromJson( jsonDecode( resp.body ) );
  }


  void searchUsers(String username) async {

    debouncer.value = '';

    debouncer.onValue = ( value ) async {

      final token = await secureStorage.readToken();

      final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-search-user/'+ username),
        headers: { 'Accept': 'application/json', 'xxx-token': token! }
      );

      final listUsers =  ResponseSearch.fromJson(jsonDecode(resp.body)).userFind;

      _streamController.add(listUsers);
    };

    final timer = Timer(const Duration(milliseconds: 200), () => debouncer.value = username);
    Future.delayed(const Duration(milliseconds: 400)).then((_) => timer.cancel());
    
  }


  Future<ResponseUserSearch> getAnotherUserById(String idUser) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-another-user-by-id/'+ idUser),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );

    return ResponseUserSearch.fromJson(jsonDecode(resp.body));
  }


  Future<DefaultResponse> addNewFollowing(String uidFriend) async {

    final token = await secureStorage.readToken();

    final resp = await http.post(Uri.parse('${Environment.urlApi}/user/add-new-friend'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
      body: { 'uidFriend': uidFriend }
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<DefaultResponse> acceptFollowerRequest(String uidFriend, String uidNotification) async {

    final token = await secureStorage.readToken();

    final resp = await http.post(Uri.parse('${Environment.urlApi}/user/accept-follower-request'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
      body: { 
        'uidFriend': uidFriend,
        'uidNotification' : uidNotification 
      }
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<DefaultResponse> deleteFollowing(String uidUser) async {

    final token = await secureStorage.readToken();

    final resp = await http.delete(Uri.parse('${Environment.urlApi}/user/delete-following/' + uidUser),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<List<Following>> getAllFollowing() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-all-following'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
    );

    return ResponseFollowings.fromJson( jsonDecode(resp.body) ).followings;
  }


  Future<List<Follower>> getAllFollowers() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-all-followers'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
    );

    return ResponseFollowers.fromJson( jsonDecode(resp.body) ).followers;
  }


  Future<DefaultResponse> deleteFollowers(String uidUser) async {

    final token = await secureStorage.readToken();

    final resp = await http.delete(Uri.parse('${Environment.urlApi}/user/delete-followers/' + uidUser),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }




}

final userService = UserServices();