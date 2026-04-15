import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Cusbuttonwithlogo extends StatelessWidget {
  const Cusbuttonwithlogo({
    super.key,
    required this.text,
    required this.wid,
    required this.hig,
    this.color1,
    this.color2,
    this.icon,
  });
  final Widget text;
  final dynamic icon;
  final double wid;
  final double hig;
  final dynamic color1;
  final dynamic color2;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.all(screenWidth * .03),
      width: wid,
      height: hig,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
      ),
      child: Row(
        children: [Gap(screenWidth * .04), icon, Gap(screenWidth * .02), text],
      ),
    );
  }
}
