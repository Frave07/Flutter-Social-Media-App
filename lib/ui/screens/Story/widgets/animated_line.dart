import 'package:flutter/material.dart';


class AnimatedLineStory extends StatelessWidget {

  final int index;
  final int selectedIndex;
  final AnimationController animationController;

  const AnimatedLineStory({
    Key? key,
    required this.index,
    required this.selectedIndex,
    required this.animationController
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return LinearProgressIndicator(
            value: index < selectedIndex 
              ? 1.0 
              : index == selectedIndex 
              ? animationController.value 
              : 0.0,
            minHeight: 4,
            backgroundColor: Colors.white54,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          );
        },
      ),
    );
  }
}