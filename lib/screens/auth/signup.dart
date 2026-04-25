import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../constant/Names.dart';
import '../../cubit/auth/signup_cubit/signup_cubit.dart';
import '../../functions/crud.dart';
import '../../functions/valid.dart';
import 'login.dart';
import '../homepage.dart';
import '../../widgets/avtarselector.dart';
import '../../widgets/cusbuttonwithlogo.dart';
import '../../widgets/custombutton.dart';
import '../../widgets/textfield.dart';

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
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                title: "نجح",
                desc: "أهلاً يا ${state.username}",
                btnOkOnPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Homepage()),
                  );
                },
              ).show();
            }

            if (state is SignupError) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: "فشل",
                desc: state.error,
                btnOkOnPress: () {},
              ).show();
            }
          },
          child: SingleChildScrollView(
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
                          upperfontsize: screenWidth * .03,

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
                          ), obscureText: false,
                        ),
                        Gap(screenHeight * .02),
                        Textfieldwid(
                          upperfontsize: screenWidth * .03,

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
                          ), obscureText: false,
                        ),
                        Gap(screenHeight * .02),

                        Textfieldwid(
                          upperfontsize: screenWidth * .03,

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
                          ), obscureText: false,
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
                  child: BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      if (state is SignupLoading) {
                        return const CircularProgressIndicator();
                      }
                      return InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SignupCubit>().Signup(
                              email: email.text,
                              username: username.text,
                              password: password.text,
                            );
                          }
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
                      );
                    },
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
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
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
        ),
      ),
    );
  }
}
