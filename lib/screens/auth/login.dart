import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:hyper_task/constant/Names.dart';
import 'package:hyper_task/functions/valid.dart';
import 'package:hyper_task/main.dart';
import 'package:hyper_task/screens/auth/signup.dart';
import 'package:hyper_task/screens/homepage.dart';
import 'package:hyper_task/widgets/cusbuttonwithlogo.dart';
import 'package:hyper_task/widgets/custombutton.dart';
import 'package:hyper_task/widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future login() async {
    if (formKey.currentState!.validate()) {
      var response = await http.post(
        Uri.parse(ApiLink.loginlink),
        body: {"email": email.text, "password": password.text},
      );

      print(response.body);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data['status'] == "success") {
          sharedpref.setString("id", data['user']['id'].toString());
          sharedpref.setString("email", data['user']['email']);
          sharedpref.setString("username", data['user']['username']);
          print("Welcome " + data['user']['username']);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success, // أيقونة النجاح الخضراء
            animType: AnimType.bottomSlide,
            title: 'تمت العملية بنجاح',
            desc: 'أهلاً بك يا ${data['user']['username']} ',
            btnOkOnPress: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Homepage(),
                ),
              );
            },
          ).show();
        } else {
          print(data['message']);
          String errorMsg = data['message'] ?? "خطأ غير معروف";
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error, // أيقونة الخطأ الحمراء
            animType: AnimType.scale,
            headerAnimationLoop: false,
            title: 'خطأ في العملية',
            desc: errorMsg, // هنا هيظهر "User not found" أو "Wrong password"
            btnOkText: "حاول مرة أخرى",
            btnOkColor: Colors.red,
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        print("Server Error");
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
          children: [
            Stack(
              children: [
                Image.asset("assets/Splash2/Top decorative element.png"),
                Positioned(
                  left: screenWidth * .38,
                  top: screenHeight * .12,
                  child: Image.asset(
                    "assets/Splash2/Background.png",
                    width: screenWidth * .25,
                  ),
                ),
                Positioned(
                  left: screenWidth * .28,
                  top: screenHeight * .224,
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
                      fontSize: screenWidth * .085,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            Gap(screenHeight * .02),

            Text(
              textAlign: TextAlign.center,
              "Find your focus in a digital space\ndesigned for your peace of mind.",
              style: TextStyle(
                fontSize: screenWidth * .045,
                fontWeight: FontWeight.w300,
              ),
            ),
            Gap(screenHeight * .035),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Textfieldwid(
                    colorupper: const Color.fromARGB(134, 0, 0, 0),
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
                  Gap(screenHeight * .01),

                  Textfieldwid(
                    valid: (val) {
                      return validinput(val!, 5, 40, "password");
                    },
                    colorupper: const Color.fromARGB(134, 0, 0, 0),
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
            MaterialButton(
              padding: EdgeInsets.only(left: screenWidth * .55),
              onPressed: () {},
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: screenWidth * .03,
                  color: Color.fromARGB(255, 93, 44, 206),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Gap(screenHeight * .01),

            InkWell(
              onTap: () {
                login();
              },
              child: Custombuttonwid(
                color1: Color(0xff652FE7),
                color2: Color(0xff006386),
                text: Text(
                  "Enter Sanctuary",
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
            Gap(screenHeight * .035),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    endIndent: 5,
                    indent: 30,
                    thickness: .8,
                    color: Colors.grey,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR CONTINUE WITH",
                    style: TextStyle(
                      fontSize: screenWidth * .03,
                      color: Color.fromARGB(255, 90, 90, 90),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Expanded(
                  child: Divider(
                    endIndent: 30,
                    indent: 5,
                    thickness: .8,
                    color: Colors.grey,
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
                  color1: Color.fromARGB(24, 197, 197, 197),

                  color2: Color.fromARGB(38, 197, 197, 197),
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
                  color1: Color.fromARGB(255, 224, 216, 216),
                  color2: Color.fromARGB(129, 10, 59, 77),
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
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: screenWidth * .035,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'pop',
                ),
                children: [
                  const TextSpan(text: "New Here ? "),
                  TextSpan(
                    text: "Register",
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
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
