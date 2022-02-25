import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/login/login_page.dart';
import 'package:social_media/ui/screens/login/register_page.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class StartedPage extends StatelessWidget {

  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              width: size.width,
              child: Row(
                children: [
                  Image.asset('assets/img/logo-black.png', height: 30),
                  const TextCustom(text: 'Frave', fontWeight: FontWeight.w500, color: ColorsFrave.primary),
                  const TextCustom(text: ' Social', fontSize: 17)
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                width: size.width,
                child: SvgPicture.asset('assets/svg/undraw_post_online.svg'),
              ),
            ),

            const TextCustom(
              text: 'Bienvenido !', 
              letterSpacing: 2.0, 
              color: ColorsFrave.secundary,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),

            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextCustom(
                text: 'El mejor lugar para escribir historias y compartir tus experiencias.',
                textAlign: TextAlign.center,
                maxLines: 2,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 50,
                width: size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ColorsFrave.secundary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                  ),
                  child: const TextCustom(text: 'Iniciar sesión', color: Colors.white, fontSize: 20),
                  onPressed: () => Navigator.push(context, routeSlide(page: const LoginPage())), 
                ),
              ),
            ),

            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: ColorsFrave.secundary, width: 1.5)
                ),
                child: TextButton(
                  child: const TextCustom(text: 'Registrate', color: ColorsFrave.secundary, fontSize: 20),
                  onPressed: () => Navigator.push(context, routeSlide(page: const RegisterPage())), 
                ),
              ),
            ),
            const SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }
}