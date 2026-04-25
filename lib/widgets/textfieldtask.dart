import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Textfieldtask extends StatelessWidget {
  const Textfieldtask({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.perfixicon,
    this.sufixicon,
    this.colorupper,
    this.hintcolor,
    this.valid,
    required this.upperfontsize,
    required this.uppertitle,
    required this.mycontroller,
    required this.lines,
  });
  final String hintText;
  final dynamic keyboardType;
  final dynamic perfixicon;
  final dynamic sufixicon;
  final dynamic colorupper;
  final dynamic hintcolor;
  final String? Function(String?)? valid;
  final double upperfontsize;
  final int lines;
  final String uppertitle;
  final TextEditingController mycontroller;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          padding: EdgeInsets.only(left: screenWidth * .02),
          child: Text(
            uppertitle,
            style: TextStyle(
              fontSize: upperfontsize,
              color: colorupper,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Gap(screenHeight * .003),
        SizedBox(
          width: screenWidth * .9,
          child: TextFormField(
            maxLines: lines,
            keyboardType: keyboardType,
            controller: mycontroller,
            validator: valid,
            decoration: InputDecoration(
              prefixIcon: perfixicon,
              suffixIcon: sufixicon,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: screenWidth * .04,
                color: hintcolor,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: const Color.fromARGB(
                    255,
                    0,
                    116,
                    212,
                  ).withOpacity(0.5),
                  width: 1.5,),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Color.fromARGB(160, 1, 18, 173),
                  width: 1.7,
                ),
              ),

              contentPadding: EdgeInsets.symmetric(
                vertical: screenHeight * .02,
                horizontal: screenWidth * .02,
              ),
              fillColor: const Color.fromRGBO(197, 195, 195, 0.096),
              filled: true,
            ),
          ),
        ),
      ],
    );
    ;
  }
}
