
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyper_task/constant/Names.dart';
import 'package:hyper_task/functions/crud.dart';
import 'package:hyper_task/functions/valid.dart';
import 'package:hyper_task/screens/auth/login.dart';
import 'package:hyper_task/screens/homepage.dart';
import 'package:hyper_task/widgets/avtarselector.dart';
import 'package:hyper_task/widgets/cusbuttonwithlogo.dart';
import 'package:hyper_task/widgets/custombutton.dart';
import 'package:hyper_task/widgets/textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final Curd curd = Curd();

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      // if (!isChecked) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Please agree to the terms")),
      //   );
      //   return;
      // }
      var response = await curd.postRequest(ApiLink.signuplink, {
        "name": username.text,
        "email": email.text,
        "password": password.text,
      });
      if (response != null && response["status"] == "success") {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Homepage(),
          ),
        );
      } else {
        print("error");
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(screenHeight * .07),
            Row(
              children: [
                Gap(screenWidth * .03),
                Image.asset(
                  "assets/Splash2/Background.png",
                  width: screenWidth * .15,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: screenHeight * .01),
                  child: Text(
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
                      fontSize: screenWidth * .05,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            Gap(screenHeight * .007),
            Container(
              padding: EdgeInsets.only(left: screenWidth * .06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(screenHeight * .02),
                  Text(
                    "Create your space.",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0, // Softness of the shadow
                          color: Colors.black26, // Shadow color
                          offset: Offset(2.0, 2.0), // X and Y displacement
                        ),
                      ],
                      fontFamily: 'plus',
                      fontSize: screenWidth * .06,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(screenHeight * .01),

                  Text(
                    textAlign: TextAlign.start,
                    "Join our community of mindful creators and\nseekers.",
                    style: TextStyle(
                      fontSize: screenWidth * .04,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            Gap(screenHeight * .035),
            AvatarSelector(),
            Gap(screenHeight * .02),

            Container(
              padding: EdgeInsets.only(left: screenWidth * .04),

              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Textfieldwid(
                      colorupper: Color.fromARGB(255, 93, 44, 206),
                      valid: (val) {
                        return validinput(val!, 5, 40, "email");
                      },
                      hintText: "name@example.com",
                      uppertitle: "EMAIL ADDRESS",
                      mycontroller: email,
                      perfixicon: Icon(
                        Icons.email_outlined,
                        color: const Color.fromARGB(134, 0, 0, 0),
                      ),
                    ),
                    Gap(screenHeight * .02),
                    Textfieldwid(
                      colorupper: Color.fromARGB(255, 93, 44, 206),
                      valid: (val) {
                        return validinput(val!, 5, 40, "username");
                      },
                      hintText: "username",
                      uppertitle: "USERNAME",
                      mycontroller: username,
                      perfixicon: Icon(
                        Icons.person_2_outlined,
                        color: const Color.fromARGB(134, 0, 0, 0),
                      ),
                    ),
                    Gap(screenHeight * .02),

                    Textfieldwid(
                      colorupper: Color.fromARGB(255, 93, 44, 206),
                      valid: (val) {
                        return validinput(val!, 5, 40, "password");
                      },
                      hintText: "••••••••",
                      uppertitle: "PASSWORD",
                      mycontroller: password,
                      perfixicon: Icon(
                        Icons.lock_outline,
                        color: const Color.fromARGB(134, 0, 0, 0),
                      ),
                      sufixicon: Icon(
                        Icons.remove_red_eye_outlined,
                        size: screenWidth * .055,
                        color: const Color.fromARGB(134, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(screenHeight * .01),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(screenWidth * .04),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: screenWidth * .001,
                      top: screenHeight * .015,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: screenWidth * .035,
                          color: Colors.grey[700],
                        ),
                        children: [
                          TextSpan(text: "I agree to the "),

                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Terms clicked");
                              },
                          ),

                          TextSpan(text: " and "),

                          TextSpan(
                            text: "Privacy \nPolicy",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Privacy clicked");
                              },
                          ),

                          TextSpan(text: "."),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Gap(screenHeight * .02),

            Center(
              child: InkWell(
                onTap: () {
                  signup();
                },
                child: Custombuttonwid(
                  color1: Color(0xff652FE7),
                  color2: Color(0xff006386),
                  text: Text(
                    "Complete Registration",
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
            ),
            Gap(screenHeight * .035),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: screenWidth * .035,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'pop',
                  ),
                  children: [
                    const TextSpan(text: "Already have an account?"),
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: screenWidth * .035,
                        color: Color.fromARGB(255, 93, 44, 206),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'pop',
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            Gap(screenHeight * .035),

            Row(
              children: [
                Expanded(
                  child: Divider(
                    endIndent: 5,
                    indent: 30,
                    thickness: .8,
                    color: Color.fromARGB(113, 90, 90, 90),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR CONTINUE WITH",
                    style: TextStyle(
                      fontSize: screenWidth * .03,
                      color: Color.fromARGB(113, 90, 90, 90),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Expanded(
                  child: Divider(
                    endIndent: 30,
                    indent: 5,
                    thickness: .8,
                    color: Color.fromARGB(113, 90, 90, 90),
                  ),
                ),
              ],
            ),
            Gap(screenHeight * .03),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cusbuttonwithlogo(
                  icon: Image.asset(
                    "assets/icons/google.png",
                    width: screenWidth * .05,
                  ),
                  color1: Color.fromARGB(99, 197, 197, 197),

                  color2: Color.fromARGB(82, 197, 197, 197),
                  text: Text(
                    "Google",
                    style: TextStyle(
                      fontSize: screenWidth * .035,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pop',
                    ),
                  ),
                  wid: screenWidth * .34,
                  hig: screenHeight * .055,
                ),
                Gap(screenWidth * .04),
                Cusbuttonwithlogo(
                  icon: Image.asset(
                    "assets/icons/apple.png",
                    width: screenWidth * .05,
                  ),
                  color1: Color.fromARGB(172, 224, 216, 216),
                  color2: Color.fromARGB(188, 10, 59, 77),
                  text: Text(
                    "Apple",
                    style: TextStyle(
                      fontSize: screenWidth * .035,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pop',
                    ),
                  ),
                  wid: screenWidth * .34,
                  hig: screenHeight * .055,
                ),
              ],
            ),
            Gap(screenHeight * .03),
          ],
        ),
      ),
    );
  }
}
