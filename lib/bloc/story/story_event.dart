part of 'story_bloc.dart';

@immutable
abstract class StoryEvent {}

class OnSelectedImagePreviewEvent extends StoryEvent {
  final File image;

  OnSelectedImagePreviewEvent(this.image);
} 

class OnAddNewStoryEvent extends StoryEvent {
  final String image;

  OnAddNewStoryEvent(this.image);
}

