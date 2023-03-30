import 'package:flutter/material.dart';
import 'package:social_media/ui/widgets/widgets.dart';

void modalSelectPicture({ required BuildContext context, required String title, Function()? onPressedImage, Function()? onPressedPhoto }) {

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black12,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 170,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(text: title, fontWeight: FontWeight.w500, fontSize: 16),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onPressedImage, 
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  foregroundColor: Colors.grey
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(Icons.wallpaper_rounded, color: Colors.black87),
                      SizedBox(width: 10.0),
                      TextCustom(text: 'Seleccionar de galeria', fontSize: 17),
                    ],
                  ))
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onPressedPhoto, 
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  foregroundColor: Colors.grey
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(Icons.photo_camera_outlined, color: Colors.black87),
                      SizedBox(width: 10.0),
                      TextCustom(text: 'Tomar una foto', fontSize: 17),
                    ],
                  ))
              ),
            ),
          ],
        ),
      ),
    ),
  );


}