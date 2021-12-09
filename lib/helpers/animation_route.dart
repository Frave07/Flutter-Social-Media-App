import 'package:flutter/material.dart';


Route routeSlide({ required Widget page, Curve curved = Curves.easeInOut }){

  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
      final curvedAnimation = CurvedAnimation(parent: animation, curve: curved);

      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(curvedAnimation),
        child: child,
      );

    },
  );
}

Route routeFade({ required Widget page, Curve curved = Curves.easeInOut }){

  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
      final curvedAnimation = CurvedAnimation(parent: animation, curve: curved);

      return FadeTransition(
        opacity: curvedAnimation,
        child: child,
      );

    },
  );
}