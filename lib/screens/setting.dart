import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyper_task/constant/Names.dart';
import 'package:hyper_task/main.dart';
import 'package:hyper_task/screens/splashtwo.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool pushNotifications = true;
  bool emailUpdates = false;

  @override
  Widget build(BuildContext context) {
    // 📏 تعريف أبعاد الشاشة
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              margin: EdgeInsets.only(left: screenWidth * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(103, 233, 233, 233),
              ),
              child: Image.asset(avtar, width: screenWidth * 0.08),
            ),
            Gap(screenWidth * .02),
            Text(
              appname,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                // تمنع الدخول لنفس الصفحة مرة تانية لو أنت فيها
              },
              child: Image.asset(
                "assets/icons/setting.png",
                width: screenWidth * .06,
                color: Colors.deepPurple,
              ),
            ),
            Gap(screenWidth * .04),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(screenHeight * 0.02),
            Text(
              "Settings",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Personalize your digital sanctuary",
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.035,
              ),
            ),
            Gap(screenHeight * 0.04),

            // --- APPEARANCE SECTION ---
            _buildSectionTitle("APPEARANCE", screenWidth),
            _buildSettingsContainer(
              screenWidth: screenWidth,
              child: _buildSwitchTile(
                screenWidth: screenWidth,
                icon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                value: isDarkMode,
                onChanged: (val) => setState(() => isDarkMode = val),
              ),
            ),

            Gap(screenHeight * 0.03),

            // --- LANGUAGE SECTION ---
            _buildSectionTitle("LANGUAGE & REGION", screenWidth),
            _buildSettingsContainer(
              screenWidth: screenWidth,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.blueAccent,
                      size: screenWidth * 0.06,
                    ),
                    title: Text(
                      "Language",
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    subtitle: Text(
                      "English (United States)",
                      style: TextStyle(fontSize: screenWidth * 0.03),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: screenWidth * 0.04,
                    ),
                    onTap: () {},
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildLangButton(
                              "English",
                              true,
                              screenWidth,
                            ),
                          ),
                          Expanded(
                            child: _buildLangButton(
                              "العربية",
                              false,
                              screenWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(screenHeight * 0.03),

            // --- NOTIFICATIONS SECTION ---
            _buildSectionTitle("NOTIFICATIONS", screenWidth),
            _buildSettingsContainer(
              screenWidth: screenWidth,
              child: Column(
                children: [
                  _buildSwitchTile(
                    screenWidth: screenWidth,
                    icon: Icons.notifications_none,
                    title: "Push Notifications",
                    value: pushNotifications,
                    onChanged: (val) => setState(() => pushNotifications = val),
                  ),
                  const Divider(),
                  _buildSwitchTile(
                    screenWidth: screenWidth,
                    icon: Icons.email_outlined,
                    title: "Email Updates",
                    value: emailUpdates,
                    onChanged: (val) => setState(() => emailUpdates = val),
                  ),
                ],
              ),
            ),

            Gap(screenHeight * 0.03),

            // --- ACCOUNT SECTION ---
            _buildSectionTitle("ACCOUNT", screenWidth),
            _buildSettingsContainer(
              screenWidth: screenWidth,
              child: Column(
                children: [
                  _buildActionTile(
                    screenWidth,
                    Icons.person_outline,
                    "Profile Information",
                    () {},
                  ),
                  const Divider(),
                  _buildActionTile(screenWidth, Icons.logout, "Log Out", () {
                    sharedpref.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Splashtwo()),
                    );
                  }, color: Colors.redAccent),
                ],
              ),
            ),

            Gap(screenHeight * 0.05),
            Center(
              child: Text(
                "${appname} V1.0.0",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.03,
                ),
              ),
            ),
            Gap(screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenWidth * 0.02,
        left: screenWidth * 0.01,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.032,
        ),
      ),
    );
  }

  Widget _buildSettingsContainer({
    required Widget child,
    required double screenWidth,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSwitchTile({
    required double screenWidth,
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.blueAccent, size: screenWidth * 0.055),
      ),
      title: Text(title, style: TextStyle(fontSize: screenWidth * 0.04)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildActionTile(
    double screenWidth,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: screenWidth * 0.055),
      ),
      title: Text(
        title,
        style: TextStyle(color: color, fontSize: screenWidth * 0.04),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: screenWidth * 0.04),
      onTap: onTap,
    );
  }

  Widget _buildLangButton(String label, bool isSelected, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.black12, blurRadius: 4)]
            : [],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.blueAccent : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.035,
        ),
      ),
    );
  }
}
