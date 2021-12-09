part of 'post_bloc.dart';

@immutable
class PostState {

  final int privacyPost;
  final List<File>? imageFileSelected;
  final bool isSearchFriend;

  const PostState({
    this.privacyPost = 1,
    this.imageFileSelected,
    this.isSearchFriend = false,
  });

  PostState copyWith({ int? privacyPost, List<File>? imageFileSelected, bool? isSearchFriend,})
    => PostState(
        privacyPost: privacyPost ?? this.privacyPost,
        imageFileSelected: imageFileSelected ?? this.imageFileSelected,
        isSearchFriend: isSearchFriend ?? this.isSearchFriend,
      );


}


class LoadingPost extends PostState {}
class LoadingSavePost extends PostState {}

class FailurePost extends PostState {
  final String error;

  const FailurePost(this.error);
}

class SuccessPost extends PostState {}

class LoadingStory extends PostState {}
class SuccessStory extends PostState {}
