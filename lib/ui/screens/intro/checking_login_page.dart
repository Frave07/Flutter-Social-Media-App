import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/home/home_page.dart';
import 'package:social_media/ui/screens/login/started_page.dart';
import 'package:social_media/ui/themes/colors_frave.dart';
import 'package:social_media/ui/widgets/widgets.dart';


class CheckingLoginPage extends StatefulWidget {
  const CheckingLoginPage({Key? key}) : super(key: key);

  @override
  State<CheckingLoginPage> createState() => _CheckingLoginPageState();
}


class _CheckingLoginPageState extends State<CheckingLoginPage> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_animationController)..addStatusListener((status) {
      if( status == AnimationStatus.completed ){
        _animationController.reverse();
      } else if ( status == AnimationStatus.dismissed ){
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state){

        if( state is LogOut ){

          Navigator.pushAndRemoveUntil(context, routeSlide(page: const StartedPage()), (_) => false);

        }else if( state is SuccessAuthentication ){

          userBloc.add(OnGetUserAuthenticationEvent());
          Navigator.pushAndRemoveUntil(context, routeSlide(page: const HomePage()), (_) => false);

        }
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.red,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                ColorsFrave.secundary,
                ColorsFrave.primary,
                Colors.white
              ]
            )
          ),
          child: Center(
            child: SizedBox(
              height: 200,
              width: 150,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Image.asset('assets/img/logo-white.png')
                    )
                  ),
                  const SizedBox(height: 10.0),
                  const TextCustom(text: 'Verificando...', color: Colors.white)
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}