import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';

modalPrivacyPost(BuildContext context) {

  final size = MediaQuery.of(context).size;
  final postBloc = BlocProvider.of<PostBloc>(context);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20.0))),
    backgroundColor: Colors.white,
    barrierColor: Colors.black26,
    builder: (context) => Container(
      height: size.height * .45,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20.0))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(50.0)
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            const Center(
              child: TextCustom(text: 'Quienes pueden comentar?', fontWeight: FontWeight.w500 )
            ),
            
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Selecciona quienes pueden comentar tu\npublicación.', fontSize: 16, color: Colors.grey, maxLines: 2),

            const SizedBox(height: 20.0),
            InkWell(
              onTap: () => postBloc.add(OnPrivacyPostEvent(1)),
              child: Row(
                children: [
                  Stack(
                    children:  [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: ColorsFrave.primary,
                        child: Icon(Icons.public_rounded, color: Colors.white),
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (_, state) => state.privacyPost == 1 ? _Check() : const SizedBox(),
                      )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  const TextCustom(text: 'Todos', fontSize: 17,)
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () => postBloc.add(OnPrivacyPostEvent(2)),
              child: Row(
                children: [
                  Stack(
                    children:  [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: ColorsFrave.primary,
                        child: Icon(Icons.group_outlined, color: Colors.white),
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (_, state) => state.privacyPost == 2 ? _Check() : const SizedBox(),
                      )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  const TextCustom(text: 'Solor seguidores', fontSize: 17,)
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () => postBloc.add(OnPrivacyPostEvent(3)),
              child: Row(
                children: [
                  Stack(
                    children:  [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: ColorsFrave.primary,
                        child: Icon(Icons.lock_outline_rounded, color: Colors.white),
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (_, state) => state.privacyPost == 3 ? _Check() : const SizedBox(),
                      )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  const TextCustom(text: 'Nadie', fontSize: 17,)
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );

}

class _Check extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 0,
      bottom: 0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 13,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Color(0xff17bf63),
          child: Icon(Icons.check, color: Colors.white, size: 20  )
        ),
      )
    );
  }
}
