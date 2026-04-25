import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyper_task/cubit/screens/task/task_service_cubit.dart';
import 'screens/Splash.dart';
import 'screens/auth/login.dart';
import 'screens/auth/signup.dart';
import 'screens/homepage.dart';
import 'screens/splashtwo.dart';
import 'widgets/screenbuttom.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskServiceCubit(),
        ),
      ],
    
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'plus'),
        debugShowCheckedModeBanner: false,
        initialRoute: sharedpref.getString("id") == null ? "splash" : "homepage",
        routes: {
          'splash': (context) => Splash(),
          'splash2': (context) => Splashtwo(),
          'homepage': (context) => Homepage(),
          'login': (context) => Login(),
          'signup': (context) => Signup(),
          'routscreen': (context) => Screenbuttom(),
        },
      ),
    );
  }
}
