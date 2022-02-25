import 'package:flutter/material.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class ItemProfile extends StatelessWidget {

  final double height;
  final String text;
  final IconData icon;
  final Color colorText; 
  final Function() onPressed;

  const ItemProfile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.height = 45,
    this.colorText = Colors.black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0)
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: colorText),
            const SizedBox(width: 10.0),
            TextCustom(text: text, fontSize: 17, color: colorText)
          ],
        ),
      ),
    );
  }
}