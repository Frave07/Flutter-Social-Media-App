import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/models/response/response_post_saved.dart';
import 'package:social_media/services/url_service.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class SavedPostsPage extends StatelessWidget {

  final List<ListSavedPost> savedPost;

  const SavedPostsPage({Key? key, required this.savedPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextFrave(text: 'Todos los posts', fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          physics: const BouncingScrollPhysics(),
          itemCount: savedPost.length,
          itemBuilder: (context, i) {

            final List<String> listImages = savedPost[i].images.split(',');
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: SizedBox(
                height: 350,
                width: size.width,
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
                                  image: NetworkImage(URLS.baseUrl+ listImages[i])
                                )
                              ),
                          ), 
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(URLS.baseUrl + savedPost[i].avatar),
                              ),
                            const SizedBox(width: 5.0),
                            TextFrave(text: savedPost[i].username, fontWeight: FontWeight.w500, color: Colors.white ),
                            ],
                          ),
                          IconButton(
                            splashRadius: 20,
                            onPressed: (){},
                            icon: const Icon(Icons.more_vert_rounded, color: Colors.white)
                          )
                        ],
                      ),
                    ),

                    Positioned(
                      bottom: 25,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        height: 45,
                        width: size.width * .95,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              color: Colors.white.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: (){},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.favorite_outline_rounded, color: Colors.white),
                                            SizedBox(width: 8.0),
                                            TextFrave(text: '52k', fontSize: 16, color: Colors.white)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      TextButton(
                                        onPressed: (){},
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/svg/message-icon.svg', color: Colors.white),
                                            const SizedBox(width: 5.0),
                                            const TextFrave(text: '1.2k', fontSize: 16, color: Colors.white)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){},
                                        icon: SvgPicture.asset('assets/svg/send-icon.svg', height: 24, color: Colors.white)
                                      ),
                                      IconButton(
                                        onPressed: (){},
                                        icon: const Icon(Icons.bookmark_rounded, size: 27, color: Colors.white)
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
            );

          },
        ),
      ),
    );
  }
}