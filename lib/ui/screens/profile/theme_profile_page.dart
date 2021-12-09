import 'package:flutter/material.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class ThemeProfilePage extends StatelessWidget {

  const ThemeProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextFrave(text: 'Cambiar Tema', fontWeight: FontWeight.w500 ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextFrave(text: 'Día'),
                  Icon(Icons.radio_button_checked, color: ColorsFrave.primaryColorFrave )
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextFrave(text: 'Noche'),
                  Icon(Icons.radio_button_off_rounded )
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextFrave(text: 'Sistema'),
                  Icon(Icons.radio_button_off_rounded )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}