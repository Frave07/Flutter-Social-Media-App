part of 'story_bloc.dart';

@immutable
class StoryState {

  final File? image;

  const StoryState({
    this.image
  });

  StoryState copyWith({ File? image })
    => StoryState(
      image: image ?? this.image
    );
    
}


class LoadingStory extends StoryState {}

class FailureStory extends StoryState {
  final String error;

  const FailureStory(this.error);
}

class SuccessStory extends StoryState {}