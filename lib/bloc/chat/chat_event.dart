part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class OnIsWrittingEvent extends ChatEvent {
  final bool isWritting;

  OnIsWrittingEvent(this.isWritting);
}

class OnEmitMessageEvent extends ChatEvent {
  final String uidSource;
  final String uidUserTarget;
  final String message;

  OnEmitMessageEvent(this.uidSource, this.uidUserTarget, this.message);
}

class OnListenMessageEvent extends ChatEvent {
  final String uidFrom;
  final String uidTo;
  final String messages;

  OnListenMessageEvent(this.uidFrom, this.uidTo, this.messages);

}




