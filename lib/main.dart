import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(nextScreen: LoginPage()),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final Widget nextScreen;

  const SplashScreen({Key? key, required this.nextScreen}) : super(key: key);

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
      nextScreen: nextScreen, // Navigate to SecondScreen after splash
      splashIconSize: 400,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}


