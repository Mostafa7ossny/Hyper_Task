import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Textfieldwid extends StatelessWidget {
  const Textfieldwid({super.key, required this.hintText, this.keyboardType, required this.uppertitle, required this.mycontroller, this.perfixicon, this.sufixicon, this.colorupper, this.valid});
  final String hintText;
  final dynamic keyboardType;
  final dynamic perfixicon;
  final dynamic sufixicon;
  final dynamic colorupper;
  final String? Function(String?)? valid;

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
          padding: EdgeInsets.only(left: screenWidth * .04),
          child: Text(
            uppertitle,
            style: TextStyle(
              fontSize: screenWidth * .03,
              color: colorupper,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Gap(screenHeight * .003),
        SizedBox(
          height: screenHeight * .07,
          width: screenWidth * .9,
          child: TextFormField(
            keyboardType: keyboardType,
            controller: mycontroller,
            validator: valid,
            decoration: InputDecoration(
              prefixIcon: perfixicon,
              suffixIcon: sufixicon,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: screenWidth * .04,
                color: const Color.fromARGB(255, 99, 99, 99),
                fontWeight: FontWeight.w200,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color.fromARGB(0, 49, 51, 53)),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color.fromARGB(160, 1, 18, 173), width: 1.7),
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
  }
}
