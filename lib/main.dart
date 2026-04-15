import 'package:flutter/material.dart';
import 'package:hyper_task/screens/Splash.dart';
import 'package:hyper_task/screens/auth/login.dart';
import 'package:hyper_task/screens/auth/signup.dart';
import 'package:hyper_task/screens/homepage.dart';
import 'package:hyper_task/screens/splashtwo.dart';
import 'package:hyper_task/widgets/screenbuttom.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'plus'),
      debugShowCheckedModeBanner: false,
      initialRoute: sharedpref.getString("id") == null ? "login" : "routscreen",
      routes: {
        'splash': (context) => Splash(),
        'splash2': (context) => Splashtwo(),
        'homepage': (context) => Homepage(),
        'login': (context) => Login(),
        'signup': (context) => Signup(),
        'routscreen': (context) => Screenbuttom(),
      },
      home: Splash(),
    );
  }
}
