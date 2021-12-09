import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media/bloc/user/user_bloc.dart';
import 'package:social_media/helpers/animation_route.dart';
import 'package:social_media/helpers/helpers.dart';
import 'package:social_media/models/response/response_post_profile.dart';
import 'package:social_media/models/response/response_post_saved.dart';
import 'package:social_media/services/post_services.dart';
import 'package:social_media/services/url_service.dart';
import 'package:social_media/ui/components/animted_toggle.dart';
import 'package:social_media/ui/screens/profile/followers_page.dart';
import 'package:social_media/ui/screens/profile/following_page.dart';
import 'package:social_media/ui/screens/profile/list_photos_profile_page.dart';
import 'package:social_media/ui/screens/profile/saved_posts_page.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ProfilePage extends StatelessWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        
        if( state is LoadingUserState ){

          modalLoading(context, 'Actualizando imagen...');

        } 
        if ( state is SuccessUserState ){

          Navigator.pop(context);
          modalSuccess(context, 'Imagen actualizada', onPressed: () => Navigator.pop(context));

        }
        if ( state is FailureUserState ){

          Navigator.pop(context);
          errorMessageSnack(context, state.error);

        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            
            _CoverAndProfile(size: size),
    
            const SizedBox(height: 10.0),
            const _UsernameAndDescription(),
    
            const SizedBox(height: 30.0),
            const _PostAndFollowingAndFollowers(),
    
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) => previous != current,
                builder: (_, state) => AnimatedToggle(
                  values: const ['Fotos', 'Guardados'], 
                  onToggleCalbBack: (value) {
                    userBloc.add( OnToggleButtonProfile(!state.isPhotos) );
                  },
                ),
              ),
            ),
    
            const SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) => previous != current,
                builder: (_, state) => 
                  state.isPhotos
                  ? const _ListFotosProfile()
                  : const _ListSaveProfile()
              ),
            ),
           
    
          ],
        ),
        bottomNavigationBar: const BottomNavigationFrave(index: 5)
      ),
    );
  }
}



class _ListFotosProfile extends StatelessWidget {

  const _ListFotosProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostProfile>>(
      future: postService.getPostProfiles(),
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
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              mainAxisExtent: 170
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {

            final List<String> listImages = snapshot.data![i].images.split(',');

            return InkWell(
              onTap: () => Navigator.push(context, routeSlide(page: const ListPhotosProfilePage())),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(URLS.baseUrl + listImages.first)
                  )
                ),
              ),
            );
          },
        );
      }
    );
  }
}

                      
class _ListSaveProfile extends StatelessWidget {

  const _ListSaveProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListSavedPost>>(
      future: postService.getListPostSavedByUser(),
      builder: (context, snapshot) 
        => !snapshot.hasData
        ? Column(
            children: const [
              ShimmerFrave(),
              SizedBox(height: 10.0),
              ShimmerFrave(),
              SizedBox(height: 10.0),
              ShimmerFrave(),
            ],
          )
        : GridView.builder(
          itemCount: snapshot.data!.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisExtent: 170
            ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            final List<String> listImages = snapshot.data![i].images.split(',');
            return InkWell(
              onTap: () => Navigator.push(context, routeSlide(page: SavedPostsPage(savedPost: snapshot.data!))),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(URLS.baseUrl + listImages.first)
                  )
                )
              ),
            );
          }          
        ),
    );
  }
}


class _PostAndFollowingAndFollowers extends StatelessWidget {

  const _PostAndFollowingAndFollowers({Key? key}) : super(key: key);

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
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, state) 
                        => state.postsUser?.posters != null
                        ? TextFrave(text: state.postsUser!.posters.toString(),  fontSize: 22, fontWeight: FontWeight.w500)
                        : const TextFrave(text: '0')
                    ),
                    const TextFrave(text: 'Post',  fontSize: 17, color: Colors.grey,  letterSpacing: .7),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.push(context, routeSlide(page: const FollowingPage())),
                  child: Column(
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, state) 
                          => state.postsUser?.friends != null
                          ? TextFrave(text: state.postsUser!.friends.toString(),  fontSize: 22, fontWeight: FontWeight.w500)
                          : const TextFrave(text: '')
                      ),
                      const TextFrave(text: 'Siguiendo', fontSize: 17, color: Colors.grey,  letterSpacing: .7),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(context, routeSlide(page: const FollowersPage())),
                  child: Column(
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, state) 
                          => state.postsUser?.followers != null
                          ? TextFrave(text: state.postsUser!.followers.toString(),  fontSize: 22, fontWeight: FontWeight.w500)
                          : const TextFrave(text: '0')
                      ),
                      const TextFrave(text: 'Seguidores', fontSize: 17, color: Colors.grey, letterSpacing: .7),
                    ],
                  ),
                ),
                
              ],
            ),
          ],
        ),
      );
  }
}


class _UsernameAndDescription extends StatelessWidget {

  const _UsernameAndDescription({ Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, state) 
              => ( state.user?.username != null)
              ? TextFrave(text: state.user!.username != '' ? state.user!.username : 'Usuario' , fontSize: 22, fontWeight: FontWeight.w500 )
              : const CircularProgressIndicator() 
          )
        ),
        const SizedBox(height: 5.0),
        Center(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, state) 
              => ( state.user?.description != null) 
              ? TextFrave(
                  text: (state.user?.description != '' ? state.user!.description : 'Descripción'), fontSize: 17, color: Colors.grey
                )
              : const CircularProgressIndicator()
          ),
        ),
      ],
    );
  }
}


class _CoverAndProfile extends StatelessWidget {

  const _CoverAndProfile({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: size.width,
      child: Stack(
        children: [

          SizedBox(
            height: 170,
            width: size.width,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, state) 
                => ( state.user?.cover != null && state.user?.cover != '')
                ? Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(URLS.baseUrl + state.user!.cover )
                  )
                : Container(
                  height: 170,
                  width: size.width,
                  color: ColorsFrave.primaryColorFrave.withOpacity(.7),
                )
            ),
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
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (_, state)
                    => ( state.user?.image != null )
                    ? InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () => modalSelectPicture(
                          context: context,
                          title: 'Actualizar image de perfil',
                          onPressedImage: () async {

                            Navigator.pop(context);
                            AppPermission().permissionAccessGalleryOrCameraForProfile(await Permission.storage.request(), context, ImageSource.gallery);                
                          },
                          onPressedPhoto: () async {

                            Navigator.pop(context);
                            AppPermission().permissionAccessGalleryOrCameraForProfile(await Permission.camera.request(), context, ImageSource.camera);  
                          }
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage( URLS.baseUrl + state.user!.image )
                        ),
                    )
                    : const CircularProgressIndicator()
                ),
              ),
            ),
          ),

          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => modalProfileSetting(context, size),
              icon: const Icon(Icons.dashboard_customize_outlined, color: Colors.white ),
            )
          ),

          Positioned(
            right: 40,
            child: IconButton(
              onPressed: () => modalSelectPicture(
                context: context,
                title: 'Actualizar imagen de portada',
                onPressedImage: () async {
      
                  Navigator.pop(context);
                  AppPermission().permissionAccessGalleryOrCameraForCover(await Permission.storage.request(), context, ImageSource.gallery);                
      
                }, 
                onPressedPhoto: () async {
      
                  Navigator.pop(context);
                  AppPermission().permissionAccessGalleryOrCameraForCover(await Permission.camera.request(), context, ImageSource.camera);  
                }
              ),
              icon: const Icon(Icons.add_box_outlined, color: Colors.white ),
            )
          )

        ],
      ),
    );
  }
}