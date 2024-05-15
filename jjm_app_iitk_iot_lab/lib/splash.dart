import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:jjm_app_iitk_iot_lab/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child:
         LottieBuilder.asset(
          "assets/Flow.json",
          width: MediaQuery.of(context).devicePixelRatio * 150.0,
          height: MediaQuery.of(context).devicePixelRatio * 750.0,
          fit: BoxFit.cover,
          animate: true,
        ),
      ),
      nextScreen: const MyApp(),
      splashIconSize: 400,
      backgroundColor: Color.fromARGB(255, 107, 81, 223),
    );
  }
}

