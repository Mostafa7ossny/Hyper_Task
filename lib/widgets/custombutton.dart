import 'package:flutter/material.dart';

class Custombuttonwid extends StatelessWidget {
  const Custombuttonwid({
    super.key,
    required this.text,
    required this.wid,
    required this.hig, this.color1, this.color2, 
  });
  final Widget text;
  final double wid;
  final double hig;
final dynamic color1 ;
final dynamic color2 ;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: wid, //screenWidth * .8
      height: hig, //screenHeight * .07
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
      ),
      child: text
    );
  }
}
