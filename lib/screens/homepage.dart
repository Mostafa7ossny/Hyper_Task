import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyper_task/constant/Names.dart';
import 'package:hyper_task/constant/taskmodel.dart';
import 'package:hyper_task/main.dart';

import 'package:hyper_task/widgets/BottomNavigationBar.dart';
import 'package:hyper_task/widgets/cuslistbutton.dart';
import 'package:hyper_task/widgets/sqldb.dart';
import 'package:hyper_task/widgets/taskcard.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

void initState() {
    super.initState();
    // --- 2. هنا بنشغل الأنميشن أول ما الصفحة تفتح ---
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _cardOpacity = 1.0; // بيظهر
          _cardBottomPosition = 150.0; // بيطلع لمكانه الطبيعي
        });
      }
    });
  }
  
  double _cardOpacity = 0.0;
  double _cardBottomPosition = 120.0;
  bool showCard = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    String? usernameapp = sharedpref.getString("username") ?? "User";
    SqlDb sqlDb = SqlDb();
    String todayDate = DateFormat('EEEE, d MMM').format(DateTime.now());
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.all(9),
            margin: EdgeInsets.all(7.5),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(103, 233, 233, 233),
            ),
            child: Image.asset(avtar),
          ),
          Gap(screenWidth * .02),

          Text(
            appname,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple,
            ),
          ),
          Gap(screenWidth * .43),

          Image.asset(
            "assets/icons/setting.png",
            width: screenWidth * .06,
            color: const Color.fromARGB(187, 122, 122, 122),
          ),
          Gap(screenWidth * .04),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: screenWidth * .055,
                    top: screenHeight * .035,
                  ),
                  child: Text(
                    todayDate,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'pop',
                      color: const Color.fromARGB(255, 82, 82, 82),
                    ),
                  ),
                ),
                Gap(screenHeight * .01),

                Row(
                  children: [
                    Gap(screenWidth * .055),
                    Text(
                      "Good Morning,\n$usernameapp.",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(screenWidth * .09),

                    CircularPercentIndicator(
                      radius: 40, // حجم الدايرة
                      lineWidth: 8, // سمك الدايرة
                      percent: 0.6, // 60%
                      center: Text(
                        "60%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      progressColor: Colors.deepPurple,
                      backgroundColor: Colors.grey.shade200,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ],
                ),
                Gap(screenHeight * .07),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Gap(screenWidth * .05),

                      Cuslistbutton(custext: "All"),
                      Gap(screenWidth * .04),
                      Cuslistbutton(custext: "Work"),
                      Gap(screenWidth * .04),
                      Cuslistbutton(custext: "Personal"),
                      Gap(screenWidth * .04),
                      Cuslistbutton(custext: "Health"),
                    ],
                  ),
                ),
                Gap(screenHeight * .04),
                Row(
                  children: [
                    Gap(screenWidth * .06),

                    Text(
                      "Today's Tasks",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(screenWidth * .38),
                    Text(
                      "3 left",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 93, 44, 206),
                      ),
                    ),
                  ],
                ),
                Gap(screenHeight * .04),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tasksList.length,

                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    return Taskcard(task: tasksList[index]);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * .15,
            right: screenWidth * .07, // بنخليه على اليمين
            child: InkWell(
              onTap: () async {
                int response = await sqlDb.insertData(
                  "INSERT INTO 'Tasksdb' ('tasks') VALUES ('task one')",
                );
                print(response);
              },
              child: Container(
                width: 56, // مقاس الـ Floating Button الافتراضي
                height: 56,
                // شكل الزر
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff4357D2), // أزرق أفتح
                      Color(0xff2A3EB2), // أزرق أغمق
                    ],
                  ),
                ),
                // محتوى الزر
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ),

          if (showCard)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubicEmphasized,
              bottom: screenHeight * .12,
              left: screenWidth * .06,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                opacity: _cardOpacity,
                child: Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      showCard = false;
                    });
                  },
                  child: Stack(
                    // بنخلي الـ Floating Button يطلع بره حدود الكارت
                    clipBehavior: Clip.none,
                    children: [
                      // 1. الـ Container الرئيسي (الكارت البنفسجي)
                      Container(
                        width: screenWidth * 0.88,
                        padding: const EdgeInsets.all(24.0),
                        // هنا بنعمل الشكل واللون والخلفية
                        decoration: BoxDecoration(
                          // حواف دائرية كبيرة زي التصميم
                          borderRadius: BorderRadius.circular(32),
                          // التدرج اللوني (Gradient)
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight, // البداية من تحت يمين
                            end: Alignment.topLeft, // النهاية فوق شمال
                            colors: [
                              Color.fromARGB(255, 75, 46, 136), // بنفسجي غامق تحت
                              Color.fromARGB(
                                255,
                                179,
                                154,
                                226,
                              ), // بنفسجي أفتح فوق
                            ],
                          ),
                
                          // هنا بنحط النقشة المثلثية كصورة خلفية
                          // تأكد إنك ضفت الصورة في الـ assets وعملتلها تعريف في yaml
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // بنخلي الـ Column ياخد طول المحتوى بس
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 2. العنوان
                            Text(
                              "Daily $appname",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05, // حجم متجاوب
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // 3. الاقتباس
                            Text(
                              "“One step at a time is enough for me.”",
                              style: TextStyle(
                                color: Colors.white.withOpacity(
                                  0.9,
                                ), // شفافية خفيفة للكلام
                                fontSize: screenWidth * 0.04, // حجم متجاوب
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: screenHeight * .02),
                            // 4. زرار "READ MORE"
                            SizedBox(
                              width: screenWidth * .3,
                              height: screenHeight * .04,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // لون الزر أبيض
                                  foregroundColor: const Color(
                                    0xff864CFF,
                                  ), // لون الكتابة بنفسجي
                                  // مسافات داخلية
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  // حواف دائرية كبيرة للزر
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "READ MORE",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2, // تباعد بين الحروف
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                
                      // 5. زر الإضافة (Floating Action Button) المتموضع
                      // بنستخدم Positioned عشان نحدد مكانه بالظبط
                    ],
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: screenHeight * .02,
            left: screenWidth * .05,
            child: CustomFloatingNavBar(
              currentIndex: selectedIndex, // متغير لحفظ الـ Index الحالي
              onTap: (index) {
                setState(() {
                  selectedIndex = index; // حدث الـ Index لما تدوس
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
