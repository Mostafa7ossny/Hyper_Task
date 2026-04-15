import 'package:flutter/material.dart';

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({super.key});

  @override
  _AvatarSelectorState createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  int selectedIndex = 0;

  List<String> avatars = [
    "assets/signup/boy.png",
    "assets/signup/girl.png",
    "assets/signup/boy (1).png",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: screenWidth * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CHOOSE YOUR AVATAR",
            style: TextStyle(
              fontSize: screenWidth * .035,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),

          Row(
            children: [
              ...List.generate(avatars.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: screenWidth * .15,
                    margin: EdgeInsets.only(right: screenWidth * .087),
                    padding: EdgeInsets.all(2), // border space
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: selectedIndex == index
                          ? Border.all(
                              color: Color.fromARGB(255, 111, 69, 207),
                              width: 2,
                            )
                          : null,
                    ),
                    child: CircleAvatar(
                      radius: screenWidth * .08,
                      backgroundImage: AssetImage(avatars[index]),
                    ),
                  ),
                );
              }),

              Container(
                width: screenWidth * .15,

                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: CircleAvatar(
                  radius: screenWidth * .08,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    "assets/signup/Container (2).png",
                    width: screenWidth * .07,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
