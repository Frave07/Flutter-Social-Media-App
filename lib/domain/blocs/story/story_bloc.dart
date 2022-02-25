import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/domain/services/story_services.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {

  StoryBloc() : super(const StoryState()) {

    on<OnAddNewStoryEvent>( _addNewStory );
    on<OnSelectedImagePreviewEvent>( _selectedImagePreview );

  }

  Future<void> _selectedImagePreview( OnSelectedImagePreviewEvent event, Emitter<StoryState> emit ) async {

    emit( state.copyWith(image: event.image) );

  }


  Future<void> _addNewStory( OnAddNewStoryEvent event, Emitter<StoryState> emit ) async {

    try {

      emit(LoadingStory());

      final data = await storyServices.addNewStory(event.image);

        if( data.resp ){

        emit( SuccessStory() );

        emit( state.copyWith(image: null) );

      }else{
        emit(FailureStory(data.message));
      }

    } catch (e) {
      emit(FailureStory(e.toString()));
    }

  }


}
