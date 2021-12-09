import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/bloc/user/user_bloc.dart';
import 'package:social_media/helpers/animation_route.dart';
import 'package:social_media/helpers/helpers.dart';
import 'package:social_media/models/response/response_notifications.dart';
import 'package:social_media/services/notifications_services.dart';
import 'package:social_media/services/url_service.dart';
import 'package:social_media/ui/screens/home/home_page.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if( state is LoadingUserState ){
          modalLoading(context, 'Cargando...');
        }else if( state is FailureUserState ){
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }else if ( state is SuccessUserState ){
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(text: 'Actividad', fontWeight: FontWeight.w500, letterSpacing: .9, fontSize: 19 ),
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const HomePage()), (_) => false),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<List<Notificationsdb>>(
            future: notificationServices.getNotificationsByUser(),
            builder: (context, snapshot) {
              return !snapshot.hasData
              ? Column(
                  children: const[
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                  ],
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue,
                                backgroundImage: NetworkImage(URLS.baseUrl + snapshot.data![i].avatar),
                              ),
                              const SizedBox(width: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextFrave(text: snapshot.data![i].follower, fontWeight: FontWeight.w500, fontSize: 16),
                                      TextFrave(text: timeago.format(snapshot.data![i].createdAt, locale: 'es_short'), fontSize: 14, color: Colors.grey),
                                    ],
                                  ),
                                  const SizedBox(width: 5.0),
                                  if( snapshot.data![i].typeNotification == '1' )
                                    const TextFrave(text: 'Te envio solicitud ', fontSize: 16),
                                  if( snapshot.data![i].typeNotification == '3' )
                                    const TextFrave(text: 'Comenzo a seguirte', fontSize: 16),
                                  if( snapshot.data![i].typeNotification == '2' )
                                    Row(
                                      children: const [
                                        TextFrave(text:'Le dio ', fontSize: 16),
                                        TextFrave(text:'Me Gusta ', fontSize: 16, fontWeight: FontWeight.w500 ),
                                        TextFrave(text:'a tu foto', fontSize: 16),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                          
                          if( snapshot.data![i].typeNotification == '1' )
                            Card(
                              color: ColorsFrave.primaryColorFrave,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                              elevation: 0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50.0),
                                splashColor: Colors.white54,
                                onTap: (){
                                  userBloc.add(
                                    OnAcceptFollowerRequestEvent(snapshot.data![i].followersUid, snapshot.data![i].uidNotification)
                                  );
                                },
                                child: const Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: TextFrave(text: 'Aceptar', fontSize: 16, color: Colors.white),
                                )
                              ),
                            ),
                        ],
                      ),
                    );
                  },
              );
            },  
          )        
        ),
      ),
    );
  }
}

