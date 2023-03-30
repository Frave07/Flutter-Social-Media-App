part of 'widgets.dart';

class ItemModal extends StatelessWidget {

  final IconData icon;
  final String text;
  final Function() onPressed;

  const ItemModal({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: ColorsFrave.secundary
        ),
        child: Align(
          alignment: Alignment.centerLeft, 
          child: Row(
            children: [
              Icon(icon, color: Colors.black87),
              const SizedBox(width: 10.0),
              TextCustom(text: text, fontSize: 17)
            ],
          )
        ),
      ),
    );
  }
}