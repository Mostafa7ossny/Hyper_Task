import 'package:flutter/material.dart';
import 'package:hyper_task/screens/auth/login.dart';
import 'package:hyper_task/screens/auth/signup.dart';
import 'package:hyper_task/screens/homepage.dart';
import 'package:hyper_task/screens/readed.dart';
import 'package:hyper_task/screens/splashtwo.dart';
import 'package:hyper_task/widgets/BottomNavigationBar.dart';

class Screenbuttom extends StatefulWidget {
  const Screenbuttom({super.key});

  @override
  State<Screenbuttom> createState() => _ScreenbuttomState();
}

class _ScreenbuttomState extends State<Screenbuttom> {
  int selectedIndex = 0;
  late final List<Widget> _pages = [
    const Homepage(), // صفحة Dashboard (Index 0)
    const Readed(), // صفحة المهام (Index 1)
    const Login(), // صفحة النجوم (Index 2)
    const Signup(), // صفحة البروفايل (Index 3)
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. عرض المحتوى (الصفحة المختارة)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _pages[selectedIndex],
            key: ValueKey<int>(selectedIndex),
          ),

          // 2. الـ NavBar بتاعك فوق المحتوى
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.05,
            child: CustomFloatingNavBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex =
                      index; // لما الرقم يتغير، الـ body هيتغير أوتوماتيك
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
