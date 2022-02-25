import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/ui/helpers/animation_route.dart';
import 'package:social_media/domain/models/response/response_list_chat.dart';
import 'package:social_media/domain/services/chat_services.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/screens/messages/chat_message_page.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ListMessagesPage extends StatefulWidget {

  const ListMessagesPage({Key? key}) : super(key: key);

  @override
  State<ListMessagesPage> createState() => _ListMessagesPageState();
}

class _ListMessagesPageState extends State<ListMessagesPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Mensajes', fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: .8),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87 )
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: SvgPicture.asset('assets/svg/new-message.svg',height: 23 )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            
            const SizedBox(height: 10.0),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey[300]!)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        hintText: 'Buscar a un amigo',
                        hintStyle: GoogleFonts.roboto(letterSpacing: .8, fontSize: 17),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.search),
                  const SizedBox(width: 10.0)
                ],
              ),
            ),

            const SizedBox(height: 20.0),
            Flexible(
              child: FutureBuilder<List<ListChat>>(
                future: chatServices.getListChatByUser(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? Column(
                      children: const [
                        ShimmerFrave(),
                        SizedBox(height: 10.0),
                        ShimmerFrave(),
                        SizedBox(height: 10.0),
                        ShimmerFrave(),
                      ],
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) => InkWell(
                        onTap: () => 
                          Navigator.push(
                            context, 
                            routeFade(page: ChatMessagesPage( 
                              uidUserTarget:  snapshot.data![i].targetUid,
                              usernameTarget:  snapshot.data![i].username,
                              avatarTarget:  snapshot.data![i].avatar, 
                          ))),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 27,
                                backgroundImage: NetworkImage(Environment.baseUrl + snapshot.data![i].avatar),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(text: snapshot.data![i].username),
                                  const SizedBox(height: 5.0),
                                  TextCustom(text: snapshot.data![i].lastMessage, fontSize: 16, color: Colors.grey ),
                                ],
                              ),
                              const Spacer(),
                              TextCustom(text: timeago.format(snapshot.data![i].updatedAt, locale: 'es_short'), fontSize: 15 ),
                            ],
                          ),
                        ),
                      )
                    );
                },
              )
            ),
            
          ],
        ),
      ),
    );
  }
}