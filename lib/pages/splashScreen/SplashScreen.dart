import 'package:flutter/material.dart';
import 'package:libraryapp/AppRoutes.dart';
import 'package:libraryapp/screenTools/screenTools.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> alphaImage;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    alphaImage = Tween(begin: 1.0, end: 0.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    goToHome();
  }

  void goToHome() {
    animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRoutes.transition);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Opacity(
        opacity: alphaImage.value,
        child: Image.asset(
          'images/library_splash_bg.jpg',
          fit: BoxFit.fitHeight,
          width: screenWidth(context),
          height: screenHeight(context),
        ),
      ),
    );
  }
}
