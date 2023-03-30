import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:social_media/data/env/env.dart';
import 'package:social_media/data/storage/secure_storage.dart';
import 'package:social_media/domain/models/response/default_response.dart';
import 'package:social_media/domain/models/response/response_comments.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/domain/models/response/response_post_by_user.dart';
import 'package:social_media/domain/models/response/response_post_profile.dart';
import 'package:social_media/domain/models/response/response_post_saved.dart';


class PostServices {



  Future<DefaultResponse> addNewPost(String comment, String typePrivacy, List<File> images ) async {

    final token = await secureStorage.readToken();

    var request = http.MultipartRequest('POST', Uri.parse('${Environment.urlApi}/post/create-new-post'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['comment'] = comment
      ..fields['type_privacy'] = typePrivacy;
      for( var image in images ){
        request.files.add( await http.MultipartFile.fromPath('imagePosts', image.path));
      }

      final response = await request.send();
      var data = await http.Response.fromStream(response);

      return DefaultResponse.fromJson( jsonDecode(data.body) );
  }


  Future<List<Post>> getAllPostHome() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/post/get-all-posts'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );

    print(jsonDecode( resp.body ));

    return ResponsePost.fromJson( jsonDecode( resp.body )).posts;
  }

  
  Future<List<PostProfile>> getPostProfiles() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/post/get-post-by-idPerson'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );

    return ResponsePostProfile.fromJson( jsonDecode( resp.body )).post;
  }


  Future<DefaultResponse> savePostByUser(String uidPost) async {

    final token = await secureStorage.readToken();

    final resp = await http.post(Uri.parse('${Environment.urlApi}/post/save-post-by-user'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! },
      body: { 'post_uid' :  uidPost}
    );

    return DefaultResponse.fromJson(jsonDecode( resp.body ));
  }


  Future<List<ListSavedPost>> getListPostSavedByUser() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/post/get-list-saved-posts'),
      headers: { 'Accept' : 'application/json', 'xxx-token': token! }
    );
    
    return ResponsePostSaved.fromJson( jsonDecode( resp.body ) ).listSavedPost;
  }


  Future<List<Post>> getAllPostsForSearch() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/post/get-all-posts-for-search'),
      headers: {'Accept' : 'application/json', 'xxx-token' : token!}
    );

    return ResponsePost.fromJson( jsonDecode( resp.body ) ).posts;
  }


  Future<DefaultResponse> likeOrUnlikePost(String uidPost, String uidPerson) async {

    final token = await secureStorage.readToken();

    final resp = await http.post(Uri.parse('${Environment.urlApi}/post/like-or-unlike-post'),
      headers: {'Accept' : 'application/json', 'xxx-token' : token!},
      body: {
        'uidPost': uidPost,
        'uidPerson': uidPerson
      }
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<List<Comment>> getCommentsByUidPost(String uidPost) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/post/get-comments-by-idpost/'+ uidPost),
      headers: {'Accept' : 'application/json', 'xxx-token' : token!},
    );

    return ResponseComments.fromJson(jsonDecode(resp.body)).comments;
  }


  Future<DefaultResponse> addNewComment(String uidPost, String comment) async {

    final token = await secureStorage.readToken();

    final resp = await http.post(Uri.parse('${Environment.urlApi}/post/add-new-comment'),
      headers: {'Accept' : 'application/json', 'xxx-token' : token!},
      body: {
        'uidPost': uidPost,
        'comment': comment
      }
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<DefaultResponse> likeOrUnlikeComment(String uidComment) async {

    final token = await secureStorage.readToken();

    final resp = await http.put(Uri.parse('${Environment.urlApi}/post/like-or-unlike-comment'),
      headers: {'Accept' : 'application/json', 'xxx-token' : token!},
      body: {
        'uidComment': uidComment
      }
    );

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }


  Future<List<PostUser>> listPostByUser() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/post/get-all-post-by-user-id'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );

    return ResponsePostByUser.fromJson(jsonDecode(resp.body)).postUser;
  }
  

  

}

final postService = PostServices();