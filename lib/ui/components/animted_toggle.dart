import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class AnimatedToggle extends StatefulWidget {

  final List<String> values;
  final ValueChanged<bool> onToggleCalbBack;

  const AnimatedToggle({
    Key? key,
    required this.values,
    required this.onToggleCalbBack
  }) : super(key: key);

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: width * .14,
      child: Stack(
        children: [

          GestureDetector(
            onTap: () => widget.onToggleCalbBack(true),
            child: Container(
              width: width,
              height: width * .14,
              decoration: ShapeDecoration(
                color: const Color(0xffF8F9FA),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * .1))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget.values.length, (i) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .1),
                      child: TextCustom(text: widget.values[i], fontSize: width * .05,),
                    )
                )
              ),
            ),
          ),

          BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous != current,
            builder: (_, state) => AnimatedAlign(
              alignment: state.isPhotos ? Alignment.centerLeft : Alignment.centerRight, 
              duration: const Duration(milliseconds: 350),
              curve: Curves.ease,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  alignment: Alignment.center,
                  width: width * .45,
                  height: width * .12,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * .1)),
                  ),
                  child: TextCustom(text: state.isPhotos 
                    ? widget.values[0]
                    : widget.values[1],
                    fontSize: width * .05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}