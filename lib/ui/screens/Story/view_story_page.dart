import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/models/response/response_list_stories.dart';
import 'package:social_media/models/response/response_stories.dart';
import 'package:social_media/services/story_services.dart';
import 'package:social_media/services/url_service.dart';
import 'package:social_media/ui/screens/Story/widgets/animated_line.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ViewStoryPage extends StatefulWidget {

  final StoryHome storyHome;

  const ViewStoryPage({Key? key, required this.storyHome}) : super(key: key);

  @override
  State<ViewStoryPage> createState() => _ViewStoryPageState();
}

class _ViewStoryPageState extends State<ViewStoryPage> with TickerProviderStateMixin {

  late PageController _pageController;
  late AnimationController _animationController;
  int _currentStory = 0;

  @override
  void initState() {

    _pageController = PageController(viewportFraction: .99);
    _animationController = AnimationController(vsync: this);
    
    _showStory();
    _animationController.addStatusListener(_statusListener);

    super.initState();
  }

  @override
  void dispose() {

    _animationController.removeStatusListener( _statusListener );
    _animationController.dispose();

    _pageController.dispose();
    super.dispose();
  }


  void _statusListener(AnimationStatus status){
    if( status == AnimationStatus.completed ){
      _nextStory();
    }
  }


  void _showStory(){

    _animationController
      ..reset()
      ..duration = const Duration(seconds: 4)
      ..forward();
  }


  void _nextStory() {

    if( _currentStory <  widget.storyHome.countStory - 1){

      setState(() => _currentStory++);

      _pageController.nextPage(
        duration: const Duration(milliseconds: 400), 
        curve: Curves.easeInOutQuint
      );
      _showStory();

    }
  }


  void _previousStory(){

    if( _currentStory > 0 ){
      setState(() => _currentStory--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400), 
        curve: Curves.easeInOutQuint
      );
      _showStory();
    }

  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<List<ListStory>>(
        future: storyServices.getStoryByUSer(widget.storyHome.uidStory),
        builder: (context, snapshot) {
          return !snapshot.hasData
          ? const ShimmerFrave()
          : Stack(
              fit: StackFit.expand,
              children: [
                  GestureDetector(
                    onTapDown: (details){
                      if( details.globalPosition.dx < size.width / 2 ){
                        _previousStory();
                      }else{
                        _nextStory();
                      }
                    } ,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: URLS.baseUrl + snapshot.data![index].media
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30.0),

                        // * Animated Line //
                        Row(
                          children: List.generate(snapshot.data!.length, (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                child: AnimatedLineStory(
                                  index: index, 
                                  selectedIndex: _currentStory, 
                                  animationController: _animationController
                                ),
                              )
                            )
                          ),
                        ),


                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(URLS.baseUrl + widget.storyHome.avatar),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFrave(text: widget.storyHome.username, color: Colors.white ),
                                  const TextFrave(text: 'Hace 5 horas', color: Colors.white70, fontSize: 14)
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context), 
                              icon: const Icon(Icons.close, color: Colors.white, )
                            )
                          ],
                        ),
                        
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    color: Colors.white.withOpacity(.1),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 20.0),

                                        hintText: 'Escribe un comentario',
                                        hintStyle: GoogleFonts.roboto(color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ),
                            const SizedBox(width: 10.0),
                            IconButton(
                              onPressed: (){}, 
                              icon: const Icon(Icons.send_rounded, color: Colors.white )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                 
                  
              ],
            );
        },
      ),
    );
  }
}