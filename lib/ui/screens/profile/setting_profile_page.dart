import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/bloc/auth/auth_bloc.dart';
import 'package:social_media/bloc/user/user_bloc.dart';
import 'package:social_media/helpers/animation_route.dart';
import 'package:social_media/ui/screens/login/started_page.dart';
import 'package:social_media/ui/screens/profile/account_profile_page.dart';
import 'package:social_media/ui/screens/profile/change_password_page.dart';
import 'package:social_media/ui/screens/profile/privacy_profile_page.dart';
import 'package:social_media/ui/screens/profile/theme_profile_page.dart';
import 'package:social_media/ui/screens/profile/widgets/item_profile.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class SettingProfilePage extends StatelessWidget {

  const SettingProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextFrave(text: 'Configuración', fontSize: 19, fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          children: [
            
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Buscar',
                  hintStyle: GoogleFonts.getFont('Roboto', color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search)
                ),
              ),
            ),

            const SizedBox(height: 15.0),
            ItemProfile(
              text: 'Seguir y invitar a un amigo', 
              icon: Icons.person_add_alt,
              onPressed: (){}
            ),
            ItemProfile(
              text: 'Notificaciones', 
              icon: Icons.notifications_none_rounded,
              onPressed: (){}
            ),
            ItemProfile(
              text: 'Privacidad', 
              icon: Icons.lock_outline_rounded,
              onPressed: () => Navigator.push(context, routeSlide(page: const PrivacyProgilePage()))
            ),
            ItemProfile(
              text: 'Seguridad', 
              icon: Icons.security_outlined,
              onPressed: () => Navigator.push(context, routeSlide(page: const ChangePasswordPage()))
            ),
            ItemProfile(
              text: 'Cuenta', 
              icon: Icons.account_circle_outlined,
              onPressed: () => Navigator.push(context, routeSlide(page: const AccountProfilePage()))
            ),
            ItemProfile(
              text: 'Help', 
              icon: Icons.help_outline_rounded,
              onPressed: (){}
            ),
            ItemProfile(
              text: 'Acerda de', 
              icon: Icons.info_outline_rounded,
              onPressed: (){}
            ),
            ItemProfile(
              text: 'Temas', 
              icon: Icons.palette_outlined,
              onPressed: () => Navigator.push(context, routeSlide(page: const ThemeProfilePage()))
            ),

            const SizedBox(height: 20.0),
            Row(
              children: const [
                Icon(Icons.copyright_outlined),
                SizedBox(width: 5.0),
                TextFrave(text: 'FRAVE DEVELOPER', fontSize: 17, fontWeight: FontWeight.w500),
              ],
            ),
            const SizedBox(height: 30.0),
            const TextFrave(text: 'Sesiones', fontSize: 17, fontWeight: FontWeight.w500),
            
            const SizedBox(height: 10.0),
            ItemProfile(
              text: 'Agregar o cambiar de cuenta', 
              icon: Icons.add,
              colorText: ColorsFrave.primaryColorFrave,
              onPressed: () {}
            ),
            ItemProfile(
              text: 'Cerrar cuenta ${userBloc.state.user!.username}', 
              icon: Icons.logout_rounded,
              colorText: ColorsFrave.primaryColorFrave,
              onPressed: () {
                authBloc.add( OnLogOutEvent() );
                userBloc.add( OnLogOutUser() );
                Navigator.pushAndRemoveUntil(context, routeSlide(page: const StartedPage()), (_) => false);
              }
            ),
          ],
        ),
      ),
    );
  }
}