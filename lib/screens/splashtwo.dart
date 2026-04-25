import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../constant/Names.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import '../widgets/custombutton.dart';

class Splashtwo extends StatefulWidget {
  const Splashtwo({super.key});

  @override
  State<Splashtwo> createState() => _SplashtwoState();
}

class _SplashtwoState extends State<Splashtwo> {
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
            bottom: screenHeight * .1,
            right: screenWidth * .1,
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
          Positioned(
            top: screenHeight * .3,
            left: screenWidth * .35,
            child: Image.asset(
              "assets/Splash2/Background.png",
              width: screenWidth * .3,
            ),
          ),
          Positioned(
            top: screenHeight * .45,
            left: screenWidth * .09,
            child: Column(
              children: [
                Text(
                 appname,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 10.0, // Softness of the shadow
                        color: Colors.black26, // Shadow color
                        offset: Offset(5.0, 5.0), // X and Y displacement
                      ),
                    ],
                    fontFamily: 'plus',
                    fontSize: screenWidth * .085,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Gap(screenHeight * .02),

                Text(
                  textAlign: TextAlign.center,
                  "Your digital space for intentional living and\nmindful productivity.",
                  style: TextStyle(
                    fontSize: screenWidth * .04,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gap(screenHeight * .08),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Signup()),
                    );
                  },
                  child: Custombuttonwid(
                    color1: Color(0xff652FE7),
                    color2: Color(0xff006386),
                    text: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: screenWidth * .035,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    wid: screenWidth * .8,
                    hig: screenHeight * .07,
                  ),
                ),
                Gap(screenHeight * .02),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Login(),
                      ),
                    );
                  },
                  child: Custombuttonwid(
                    color1: Color.fromARGB(255, 197, 197, 197),
                    color2: Color.fromARGB(216, 125, 229, 255),
                    text: Text(
                      "LOG IN",
                      style: TextStyle(
                        fontSize: screenWidth * .035,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    wid: screenWidth * .8,
                    hig: screenHeight * .07,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
