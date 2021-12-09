part of 'helpers.dart';

void modalSuccess(BuildContext context, String text, {required VoidCallback onPressed}){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) 
      => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: SizedBox(
            height: 250,
            child: Column(
              children: [
                Row(
                  children: const[
                    TextFrave(text: 'Frave ', color: ColorsFrave.primaryColorFrave, fontWeight: FontWeight.w500 ),
                    TextFrave(text: 'Social', fontWeight: FontWeight.w500),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10.0),
                Container(
                  height: 90,
                  width: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Colors.white,
                        ColorsFrave.primaryColorFrave
                      ]
                    )
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsFrave.primaryColorFrave
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 38),
                  ),                  
                ),
                const SizedBox(height: 35.0),
                TextFrave(text: text, fontSize: 17, fontWeight: FontWeight.w400 ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: onPressed,
                  child: Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 150,
                    decoration: BoxDecoration(
                      color: ColorsFrave.primaryColorFrave,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: const TextFrave(text: 'Hecho', color: Colors.white, fontSize: 17 ),
                  ),
                )
              ],
            ),
          ),
      ),
  );

}