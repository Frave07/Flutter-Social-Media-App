import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/domain/services/post_services.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  List<File> listImages = [];

  PostBloc() : super(const PostState()) {

    on<OnPrivacyPostEvent>(_onPrivacyPost);
    on<OnSelectedImageEvent>(_onSelectedImage);
    on<OnClearSelectedImageEvent>(_onClearSelectedImage);
    on<OnAddNewPostEvent>(_addNewPost);
    on<OnSavePostByUser>(_savePostByUser);
    on<OnIsSearchPostEvent>(_isSearchPost);
    on<OnLikeOrUnLikePost>(_likeOrUnlikePost);
    on<OnAddNewCommentEvent>(_addNewComment);
    on<OnLikeOrUnlikeComment>(_likeOrUnlikeComment);

  }

  Future<void> _onPrivacyPost( OnPrivacyPostEvent event, Emitter<PostState> emit ) async {

    emit( state.copyWith( privacyPost: event.privacyPost ) );

  }


  Future<void> _onSelectedImage( OnSelectedImageEvent event, Emitter<PostState> emit ) async {

    listImages.add( event.imageSelected );

    emit( state.copyWith(imageFileSelected: listImages));

  }


  Future<void> _onClearSelectedImage( OnClearSelectedImageEvent event, Emitter<PostState> emit ) async {

    listImages.removeAt(event.indexImage);

    emit( state.copyWith(imageFileSelected: listImages));

  }


  Future<void> _addNewPost( OnAddNewPostEvent event, Emitter<PostState> emit ) async {

    try {

      emit( LoadingPost() );

      final data = await postService.addNewPost(event.comment, state.privacyPost.toString(), listImages);

      await Future.delayed(const Duration(milliseconds: 350));

      if( data.resp ){

        emit( SuccessPost() );

        listImages.clear();
        emit(state.copyWith( privacyPost: 1, imageFileSelected: listImages ));
        
      }else{
        emit( FailurePost(data.message) );
      }
      
    } catch (e) {
      emit(FailurePost(e.toString()));
    }

  }


  Future<void> _savePostByUser( OnSavePostByUser event, Emitter<PostState> emit ) async {

    try {

      emit(LoadingSavePost());

      final data = await postService.savePostByUser(event.idPost);

      if( data.resp ){
        emit(SuccessPost());
      }else{
        emit(FailurePost(data.message));
      }
      
    } catch (e) {
      emit(FailurePost(e.toString()));
    }

  }


  Future<void> _isSearchPost( OnIsSearchPostEvent event, Emitter<PostState> emit ) async {

     emit( state.copyWith(isSearchFriend: event.isSearchFriend));

   }


  Future<void> _likeOrUnlikePost( OnLikeOrUnLikePost event , Emitter<PostState> emit ) async {

    try {

      emit(LoadingPost());

      final data = await postService.likeOrUnlikePost(event.uidPost, event.uidPerson);

      if( data.resp ){
        emit(SuccessPost());
      }else{
        emit(FailurePost(data.message));
      }
      
    } catch (e) {
      emit(FailurePost(e.toString()));
    }

  }


  Future<void> _addNewComment( OnAddNewCommentEvent event , Emitter<PostState> emit ) async {

    try {

      emit(LoadingPost());

      final data = await postService.addNewComment(event.uidPost, event.comment);

      if(data.resp){
        emit(SuccessPost());
      }else{
        emit(FailurePost(data.message));
      }
      
    } catch (e) {
      emit(FailurePost(e.toString()));
    }

  }


  Future<void> _likeOrUnlikeComment( OnLikeOrUnlikeComment event , Emitter<PostState> emit ) async {

    try {

      emit(LoadingPost());

      final data = await postService.likeOrUnlikeComment(event.uidComment);

      if(data.resp){
        emit(SuccessPost());
      }else{
        emit(FailurePost(data.message));
      }
      
    } catch (e) {
      emit(FailurePost(e.toString()));
    }

  }






}
