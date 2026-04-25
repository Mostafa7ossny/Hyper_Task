import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../constant/Names.dart';
import '../widgets/inprogresstask.dart';
import 'package:intl/intl.dart';

class Readed extends StatefulWidget {
  const Readed({super.key});

  @override
  State<Readed> createState() => _ReadedState();
}

class _ReadedState extends State<Readed> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    String todayDate = DateFormat('EEEE, d MMM').format(DateTime.now());

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.all(9),
            margin: EdgeInsets.all(7.5),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(103, 233, 233, 233),
            ),
            child: Image.asset(avtar),
          ),
          Gap(screenWidth * .02),

          Text(
            appname,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple,
            ),
          ),
          Gap(screenWidth * .43),

          Image.asset(
            "assets/icons/setting.png",
            width: screenWidth * .06,
            color: const Color.fromARGB(187, 122, 122, 122),
          ),
          Gap(screenWidth * .04),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Gap(screenHeight * .01),

          Container(
            padding: EdgeInsets.only(left: screenWidth * .05),
            child: Text(
              "Good Morning.",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),

          Gap(screenHeight * .004),
          Container(
            padding: EdgeInsets.only(left: screenWidth * .06),
            child: Text(
              todayDate,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                fontFamily: 'pop',
                color: const Color.fromARGB(255, 119, 119, 119),
              ),
            ),
          ),
          Gap(screenHeight * .035),

          Row(
            children: [
              Gap(screenWidth * .07),
              Column(
                children: [
                  Container(
                    width: screenWidth * .4,
                    height: screenHeight * .12,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 86, 26, 207),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 189, 189, 189),
                          blurRadius: 10,
                          offset: Offset(-1, 1),
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(33),
                    ),
                  ),
                  Gap(screenHeight * .05),
                ],
              ),
              Gap(screenWidth * .05),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: screenWidth * .1),

                    width: screenWidth * .4,
                    height: screenHeight * .08,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(208, 182, 228, 255),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 219, 219, 219),
                          blurRadius: 10,
                          offset: Offset(-1, 1),
                          spreadRadius: .2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Gap(screenHeight * .01),

                  Container(
                    padding: EdgeInsets.only(left: screenWidth * .1),

                    width: screenWidth * .4,
                    height: screenHeight * .08,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(60, 214, 214, 214),

                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(screenHeight * .04),

          Row(
            children: [
              Gap(screenWidth * .06),

              Text(
                "In Progress",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              Gap(screenWidth * .26),
              Container(
                alignment: Alignment.center,
                width: screenWidth * .29,
                height: screenHeight * .033,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 246, 255),

                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "4 remaining",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
          // Inprogresstask()
        ],
      ),
    );
  }
}
