import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'map.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}); // Adjusted constructor

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splash: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/Flow.json",
                width: MediaQuery.of(context).size.width * 0.75, // Adjust size as needed
                height: MediaQuery.of(context).size.height * 0.75, // Adjust size as needed
                fit: BoxFit.cover,
                animate: true, // Double the speed
                repeat: false, // Play animation only once
              ),
            ],
          ),
        ),
      ),
      nextScreen: SecondScreen(), // Navigate to SecondScreen after splash
      splashIconSize: 400,
      backgroundColor: Color.fromARGB(255, 107, 81, 223),
    );
  }
}
