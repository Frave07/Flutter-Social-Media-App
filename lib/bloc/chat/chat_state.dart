part of 'chat_bloc.dart';

@immutable
abstract class ChatState {
  
  final bool isWritting;

  final String? uidSource;
  final String? uidTarget;
  final String? message;

  const ChatState({
    this.isWritting = false,
    this.uidSource,
    this.uidTarget,
    this.message
  });


}

class ChatInitial extends ChatState {
  const ChatInitial() : super(isWritting: false);
}

class ChatSetIsWrittingState extends ChatState {
  final bool writting;
  const ChatSetIsWrittingState({required this.writting}) : super(isWritting: writting);
}

class ChatListengMessageState extends ChatState {
  final String uidFrom;
  final String uidTo;
  final String messages;

  const ChatListengMessageState({
    required this.uidFrom, 
    required this.uidTo, 
    required this.messages
  }) : super ( uidSource: uidFrom, uidTarget: uidTo, message: messages);
}

