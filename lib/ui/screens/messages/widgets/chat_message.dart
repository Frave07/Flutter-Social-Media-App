import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/ui/themes/colors_frave.dart';


class ChatMessage extends StatelessWidget {

  final String message;
  final String uidUser;
  final DateTime? time;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.uidUser,
    required this.animationController,
    this.time
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) 
            => state.user != null 
            ? Container(
                child: uidUser == state.user!.uid
                ? _myMessages()
                : _notMyMessage()
              )
            : const SizedBox()
        ),
      ),
    );
  }


  Widget _myMessages(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextCustom(text: timeago.format(time ?? DateTime.now() , locale: 'es_short'), fontSize: 15, color: Colors.grey ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: TextCustom(text: message, color: Colors.white, fontSize: 17 ),
              decoration: BoxDecoration(
                color: ColorsFrave.primary,
                borderRadius: BorderRadius.circular(10.0)
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 50.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: TextCustom(text: message, fontSize: 17 ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0)
              ),
            ),
            TextCustom(text: timeago.format(time ?? DateTime.now(), locale: 'es_short'), fontSize: 15, color: Colors.grey )
          ],
        ),
      ),
    );
  }

}
