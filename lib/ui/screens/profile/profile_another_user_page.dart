import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/models/response/response_user_search.dart';
import 'package:social_media/domain/services/user_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/messages/chat_message_page.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ProfileAnotherUserPage extends StatefulWidget {
  final String idUser;

  const ProfileAnotherUserPage({Key? key, required this.idUser}) : super(key: key);

  @override
  State<ProfileAnotherUserPage> createState() => _ProfileAnotherUserPageState();
}


class _ProfileAnotherUserPageState extends State<ProfileAnotherUserPage> {

  @override
  Widget build(BuildContext context) {

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if( state is LoadingFollowingUser ){
          modalLoading(context, 'Cargando...');
        }else if( state is FailureUserState ){
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }else if( state is SuccessFollowingUser ){
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FutureBuilder<ResponseUserSearch>(
            future: userService.getAnotherUserById(widget.idUser),
            builder: (context, snapshot) {
              return !snapshot.hasData
              ? const _LoadingDataUser()
              : _BodyUser(responseUserSearch: snapshot.data!);
            },
          ),
        ),
      ),
    );
  }
}

class _BodyUser extends StatelessWidget {

  final ResponseUserSearch responseUserSearch;

  const _BodyUser({ Key? key, required this.responseUserSearch  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [

          _CoverAndProfile(user: responseUserSearch.anotherUser),
          const SizedBox(height: 10.0),
          _UsernameAndDescription(user: responseUserSearch.anotherUser),
          const SizedBox(height: 30.0),
          _PostAndFollowingAndFollowers(analytics: responseUserSearch.analytics),
          const SizedBox(height: 30.0),
          _BtnFollowAndMessage(
            isFriend: responseUserSearch.isFriend, 
            uidUser: responseUserSearch.anotherUser.uid,
            isPendingFollowers: responseUserSearch.isPendingFollowers,
            username: responseUserSearch.anotherUser.username,
            avatar: responseUserSearch.anotherUser.image,
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 46,
            child: Column(
              children: [
                const Icon(Icons.grid_on_rounded, size: 30),
                const SizedBox(height: 5.0),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                )
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          _ListFotosAnotherProfile(
            posts: responseUserSearch.postsUser, 
            isPrivate: responseUserSearch.anotherUser.isPrivate,
            isFriend: responseUserSearch.isFriend,
          ),

      ],
    );
  }
}


class _ListFotosAnotherProfile extends StatelessWidget {

  final List<PostsUser> posts;
  final int isPrivate;
  final int isFriend;

  const _ListFotosAnotherProfile({ Key? key, required this.posts, required this.isPrivate, required this.isFriend }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: isPrivate == 0 || isPrivate == 1 && isFriend == 1
      ? GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisExtent: 170
          ),
          itemCount: posts.length,
          itemBuilder: (context, i) {

          final List<String> listImages = posts[i].images.split(',');

          return InkWell(
            onTap: () {} ,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(Environment.baseUrl + listImages.first)
                )
              ),
            ),
          );
        },
      )
    : SizedBox(
      height: 100,
      child: Row(
        children: [
          const Icon(Icons.lock_outline_rounded, size: 40),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TextCustom(text: 'Esta cuenta es privada', fontWeight: FontWeight.w500),
              TextCustom(text: 'Sigue esta cuenta para poder ver sus fotos.', color: Colors.grey, fontSize: 16),
            ],
          )
        ],
      ),
    )
    );
  }
}


class _BtnFollowAndMessage extends StatelessWidget {

  final int isFriend;
  final int isPendingFollowers;
  final String uidUser;
  final String username;
  final String avatar;

  const _BtnFollowAndMessage({ 
    Key? key, 
    required this.isFriend, 
    required this.uidUser, 
    required this.isPendingFollowers,
    required this.username,
    required this.avatar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 43,
          width: size.width * .5,
          decoration: BoxDecoration(
            color: isFriend == 1 || isPendingFollowers == 1 ? Colors.white : ColorsFrave.primary,
            border: Border.all(color:  isFriend == 1 || isPendingFollowers == 1 ? Colors.grey : Colors.white),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: isPendingFollowers == 0 
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0) )
              ),
              child: TextCustom(
                text: isFriend == 1 ? 'Siguiendo' : 'Seguir', 
                fontSize: 20, 
                color: isFriend == 1 ? Colors.black : Colors.white
              ),
              onPressed: (){
                if( isFriend == 1 ){
                  userBloc.add( OnDeletefollowingEvent(uidUser) );
                }else{
                  userBloc.add( OnAddNewFollowingEvent(uidUser) );
                }
              }, 
            )
          : TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0) )
              ),
              child: const TextCustom(text: 'Pendiente', fontSize: 20, color: Colors.black),
              onPressed: (){
                
              }, 
            )
        ),
        Container(
          height: 43,
          width: size.width * .4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0) )
            ),
            child: const TextCustom(text: 'Mensaje', fontSize: 20),
            onPressed: () 
              => Navigator.push(
                  context, 
                  routeFade(page: ChatMessagesPage(uidUserTarget: uidUser, usernameTarget: username, avatarTarget: avatar))
              ), 
          ),
        )
      ],
    );
  }
}


class _PostAndFollowingAndFollowers extends StatelessWidget {

  final Analytics analytics;

  const _PostAndFollowingAndFollowers({Key? key, required this.analytics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        width: size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextCustom(text: analytics.posters.toString(),  fontSize: 22, fontWeight: FontWeight.w500),
                    const TextCustom(text: 'Post',  fontSize: 17, color: Colors.grey),
                  ],
                ),
                Column(
                  children: [
                    TextCustom(text: analytics.friends.toString(),  fontSize: 22, fontWeight: FontWeight.w500),
                    const TextCustom(text: 'Siguiendo', fontSize: 17, color: Colors.grey),
                  ],
                ),
                Column(
                  children: [
                    TextCustom(text: analytics.followers.toString(),  fontSize: 22, fontWeight: FontWeight.w500),
                    const TextCustom(text: 'Seguidores', fontSize: 17, color: Colors.grey),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      );
  }
}


class _UsernameAndDescription extends StatelessWidget {

  final AnotherUser user;

  const _UsernameAndDescription({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child:TextCustom(text: user.username , fontSize: 22, fontWeight: FontWeight.w500 )
        ),
        const SizedBox(height: 5.0),
        Center(
          child: TextCustom(text: user.description, fontSize: 17, color: Colors.grey)
        ),
      ],
    );
  }
}


class _CoverAndProfile extends StatelessWidget {

  final AnotherUser user;

  const _CoverAndProfile({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 200,
      width: size.width,
      child: Stack(
        children: [

          SizedBox(
            height: 170,
            width: size.width,
            child: user.cover != ''
              ? Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(Environment.baseUrl + user.cover )
                )
              : Container(
                  height: 170,
                  width: size.width,
                  color: Colors.blueGrey[200],
                )
          ),

          Positioned(
            bottom: 28,
            child: Container(
              height: 20,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: size.width,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage( Environment.baseUrl + user.image )
                ),
              ),
            ),
          ),

          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => modalOptionsAnotherUser(context),
              icon: const Icon(Icons.dashboard_customize_outlined, color: Colors.white ),
            )
          ),

          Positioned(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white ),
            )
          ),


        ],
      ),
    );
  }
}


class _LoadingDataUser extends StatelessWidget {

  const _LoadingDataUser({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [
          ShimmerFrave(),
          SizedBox(height: 10.0),
          ShimmerFrave(),
          SizedBox(height: 10.0),
          ShimmerFrave(),
          SizedBox(height: 10.0),
          ShimmerFrave(),
        ], 
      );
  }
}


