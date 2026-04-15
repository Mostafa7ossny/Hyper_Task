import 'package:flutter/material.dart';

class Cuslistbutton extends StatefulWidget {
  const Cuslistbutton({super.key, required this.custext});
  final String custext;

  @override
  State<Cuslistbutton> createState() => _CuslistbuttonState();
}

class _CuslistbuttonState extends State<Cuslistbutton> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      alignment: Alignment.center,
      width: screenWidth * .2,
      height: screenHeight * .05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 53, 53, 53),
      ),
      child: Text(
        widget.custext,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
