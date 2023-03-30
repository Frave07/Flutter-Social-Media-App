import 'package:flutter/material.dart';
import 'package:social_media/ui/widgets/widgets.dart';

void modalOptionsAnotherUser(BuildContext context ) {

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black12,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 237,
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
            Center(
              child: Container(
                height: 5,
                width: 40,
                color: Colors.grey[300]
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  foregroundColor: Colors.grey
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(Icons.report_gmailerrorred_rounded, color: Colors.red),
                      SizedBox(width: 10.0),
                      TextCustom(text: 'Reportar', fontSize: 17, color: Colors.red),
                    ],
                  ))
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  foregroundColor: Colors.grey
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(Icons.block_outlined, color: Colors.black87),
                      SizedBox(width: 10.0),
                      TextCustom(text: 'Bloquear', fontSize: 17),
                    ],
                  ))
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  foregroundColor: Colors.grey
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(Icons.copy_all_rounded, color: Colors.black87),
                      SizedBox(width: 10.0),
                      TextCustom(text: 'Copiar URL del perfil', fontSize: 17),
                    ],
                  ))
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  foregroundColor: Colors.grey
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(Icons.share_outlined, color: Colors.black87),
                      SizedBox(width: 10.0),
                      TextCustom(text: 'Compartir este perfil', fontSize: 17),
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