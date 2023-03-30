import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/ui/screens/reels/widgets/modal_more_option.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ReelHomeScreen extends StatelessWidget {

  const ReelHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Image.asset('assets/img/logo.png'),
          ),

          const Positioned(
            left: 15,
            top: 30,
            child: TextCustom(text: 'Fraved', color: Colors.white, isTitle: true, fontWeight: FontWeight.w600)
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage('assets/img/logo.png')
                    ),
                    const SizedBox(width: 10.0),
                    const TextCustom(text: 'FrankPe', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.0),
                    const SizedBox(width: 10.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.white)
                      ),
                      child: const TextCustom(text: 'Seguir', color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500,),
                    )
                  ],
                ),
                const SizedBox(height: 15.0),
                const TextCustom(text: 'Description', fontSize: 14, color: Colors.white, maxLines: 4, overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 15.0),
                Row(
                  children: const [
                    Icon(Icons.music_note_rounded, color: Colors.white, size: 15,),
                    SizedBox(width: 5.0),
                    TextCustom(text: 'Nombre de la musica', color: Colors.white, fontSize: 14.0,)
                  ],
                )
              ],
            )
          ),

          Positioned(
            right: 10,
            bottom: 20,
            child: Column(
              children: [
                Column(
                  children: const [
                    Icon(Icons.favorite_border_rounded, color: Colors.white, size: 30),
                    SizedBox(height: 5.0),
                    TextCustom(text: '524', color: Colors.white, fontSize: 13,)
                  ],
                ),
                const SizedBox(height: 15.0),
                Column(
                  children: [
                    SvgPicture.asset('assets/svg/message-icon.svg', height: 30,),
                    const SizedBox(height: 5.0),
                    const TextCustom(text: '1504', color: Colors.white, fontSize: 13,)
                  ],
                ),
                const SizedBox(height: 20.0),
                const Icon(Icons.share_outlined, color: Colors.white, size: 26),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => modalOptionsReel(context),
                  child: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 26)
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.white, width: 2)
                  ),
                  child: Image.asset('assets/img/logo.png')
                )
              ],
            )
          )

        ],
      ),
      bottomNavigationBar: const BottomNavigationFrave(index: 3, isReel: true),
    );
  }
}