import 'package:flutter/material.dart';
import 'package:hyper_task/screens/splashtwo.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 250, 253, 255),
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * .17,
            left: screenWidth * .25,
            child: Image.asset(
              "assets/Splash1/tasssk.png",
              width: screenWidth * .07,
            ),
          ),
          Positioned(
            bottom: screenHeight * .2,
            right: screenWidth * .2,
            child: Image.asset(
              "assets/Splash1/Container (1).png",
              width: screenWidth * .1,
            ),
          ),
          Positioned(
            top: screenHeight * .45,
            child: Image.asset(
              "assets/Splash1/Container.png",
              width: screenWidth * .2,
            ),
          ),
          Center(
            child: LottieBuilder.asset(
              "assets/Splash1/Completing Tasks (1).json",
              width: screenWidth * .4,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Splashtwo()),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
