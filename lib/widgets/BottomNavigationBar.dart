import 'package:flutter/material.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomFloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // شلنا الـ Center والـ Stack عشان ميعملوش تضارب مع الـ Positioned
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.dashboard_outlined, Icons.dashboard),
          _buildNavItem(1, Icons.done_all_outlined, Icons.done_all),
          _buildNavItem(2, Icons.stars_outlined, Icons.stars),
          _buildNavItem(3, Icons.person_outline, Icons.person),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque, // عشان يلقط اللمسة في أي مكان
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut, // حركة "سوستة" واضحة جداً
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          // هنا السر: اللون بيتغير بانسيابية
          color: isSelected ? const Color(0xff864CFF).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? filledIcon : outlineIcon,
              size: isSelected ? 28 : 24,
              color: isSelected ? const Color(0xff864CFF) : const Color(0xff9E9E9E),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Task", // تقدر تغيرها حسب الـ index
                  style: TextStyle(
                    color: Color(0xff864CFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}