import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/screens/addPost/add_post_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media/domain/models/response/response_stories.dart';
import 'package:social_media/domain/services/story_services.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/Story/add_story_page.dart';
import 'package:social_media/ui/screens/Story/view_story_page.dart';
import 'package:social_media/ui/screens/comments/comments_post_page.dart';
import 'package:social_media/ui/screens/messages/list_messages_page.dart';
import 'package:social_media/ui/screens/notifications/notifications_page.dart';
import 'package:social_media/domain/models/response/response_post.dart';
import 'package:social_media/domain/services/post_services.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if( state is LoadingSavePost || state is LoadingPost){
          modalLoadingShort(context);
        }else if ( state is FailurePost ){
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }else if ( state is SuccessPost ){
          Navigator.pop(context);
          setState((){});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Frave social', fontWeight: FontWeight.w600, fontSize: 22, color: ColorsFrave.secundary, isTitle: true,),
          elevation: 0,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, routeSlide(page: const AddPostPage()), (_) => false);
              },
              icon: SvgPicture.asset('assets/svg/add_rounded.svg', height: 32)
            ),
            IconButton(
              splashRadius: 20,
              onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const NotificationsPage()), (_) => false),
              icon: SvgPicture.asset('assets/svg/notification-icon.svg', height: 26)
            ),
            IconButton(
              splashRadius: 20,
              onPressed: () => Navigator.push(context, routeSlide(page: const ListMessagesPage())), 
              icon: SvgPicture.asset('assets/svg/chat-icon.svg', height: 24)
            ),
    
          ],
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              
              const _ListHistories(),
    
              const SizedBox(height: 5.0),
              FutureBuilder<List<Post>>(
                future: postService.getAllPostHome(),
                builder: (_, snapshot) {

                  if( snapshot.data != null && snapshot.data!.isEmpty){
                    return _ListWithoutPosts();
                  }

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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, i) => _ListViewPosts(posts: snapshot.data![i]),
                    );
                  
                },
              ),
              
    
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationFrave(index: 1)
      ),
    );
  }
}

class _ListHistories extends StatelessWidget {

  const _ListHistories({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 90,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) 
              =>  state.user != null
              ? InkWell(
                onTap: () => Navigator.push(context, routeSlide(page: const AddStoryPage())),
                child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Colors.pink,
                              Colors.amber
                            ]
                          )
                        ),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(Environment.baseUrl + state.user!.image.toString() )
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      TextCustom(text: state.user!.username, fontSize: 15)
                    ],
                ),
              )
              : const CircleAvatar()
          ),

          const SizedBox(width: 10.0),
          SizedBox(
            height: 90,
            width: size.width,
            child: FutureBuilder<List<StoryHome>>(
              future: storyServices.getAllStoriesHome(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                ? const ShimmerFrave()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => Navigator.push(context, routeFade(page: ViewStoryPage(storyHome:  snapshot.data![i]))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                     begin: Alignment.topCenter,
                                      colors: [
                                        Colors.pink,
                                        Colors.amber
                                      ]
                                  )
                                ),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(Environment.baseUrl + snapshot.data![i].avatar )
                                    )
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextCustom(text: snapshot.data![i].username, fontSize: 15)
                            ],
                          ),
                        ),
                      );
                    },
                  );
              },
            ),
          )

        ],
      ),
    );
  }
}


class _ListViewPosts extends StatelessWidget {

  final Post posts;

  const _ListViewPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);

    final List<String> listImages = posts.images.split(',');
    final time =  timeago.format(posts.createdAt, locale: 'es');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        height: 350,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[100]
        ),
        child: Stack(
          children: [
    
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CarouselSlider.builder(
                itemCount: listImages.length,                 
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  height: 350,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: false,
                ),
                itemBuilder: (context, i, realIndex) 
                  => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(Environment.baseUrl+ listImages[i])
                        )
                      ),
                  ), 
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(Environment.baseUrl + posts.avatar),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(text: posts.username, color: Colors.white, fontWeight: FontWeight.w500 ),
                                  TextCustom(text: time, fontSize: 15, color: Colors.white ),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 25)
                          )
                          
                        ],
                      ),
                    ],
                  ),
    
                  Positioned(
                    bottom: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: 45,
                      width: size.width * .9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            color: Colors.white.withOpacity(0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => postBloc.add( OnLikeOrUnLikePost(posts.postUid, posts.personUid) ),
                                          child: posts.isLike == 1 
                                          ? const Icon(Icons.favorite_rounded, color: Colors.red)
                                          : const Icon(Icons.favorite_outline_rounded, color: Colors.white),
                                        ),
                                        const SizedBox(width: 8.0),
                                        InkWell(
                                          onTap: () {},
                                          child: TextCustom(text: posts.countLikes.toString(), fontSize: 16, color: Colors.white)
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 20.0),
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                        context, 
                                        routeFade(page: CommentsPostPage(uidPost: posts.postUid))
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/svg/message-icon.svg'),
                                          const SizedBox(width: 5.0),
                                          TextCustom(text: posts.countComment.toString(), fontSize: 16, color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){},
                                      icon: SvgPicture.asset('assets/svg/send-icon.svg', height: 24)
                                    ),
                                    IconButton(
                                      onPressed: () => postBloc.add(OnSavePostByUser( posts.postUid )),
                                      icon: const Icon(Icons.bookmark_border_rounded, size: 27, color: Colors.white)
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}


class _ListWithoutPosts extends StatelessWidget {


  final List<String> svgPosts = [
    'assets/svg/without-posts-home.svg',
    'assets/svg/without-posts-home.svg',
    'assets/svg/mobile-new-posts.svg',
  ];

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(3, (index) => Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          padding: const EdgeInsets.all(10.0),
          height: 350,
          width: size.width,
          // color: Colors.amber,
          child: SvgPicture.asset(svgPosts[index], height: 15),
        ),
      ),
    );
  }
  
}



