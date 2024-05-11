import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:jjm_app_iitk_iot_lab/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: LottieBuilder.asset(
            "assets/Flow.json",
            // Use MediaQuery to get screen dimensions
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.contain, // Ensure animation fits within screen
            animate: true,
          ),
        ),
      ),
      nextScreen: const MyApp(),
      splashIconSize: 400,
      backgroundColor: Color.fromARGB(255, 107, 81, 223),
    );
  }
}
