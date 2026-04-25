import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hyper_task/screens/setting.dart';
import '../constant/taskmodel.dart';
import '../cubit/screens/task/task_service_cubit.dart';
import '../widgets/taskcard.dart';
import '../constant/Names.dart';
import 'add_task.dart';
import '../functions/crud.dart';
import '../main.dart';
import 'splashtwo.dart';
import '../widgets/BottomNavigationBar.dart';
import '../widgets/category.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double cardOpacity = 0.0;
  double cardBottomPosition = 120.0;
  bool showCard = true;
  int selectedIndex = 0;
  @override
  void initState() {
    context.read<TaskServiceCubit>().gettasks();

    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          cardOpacity = 1.0;
          cardBottomPosition = 150.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
            child: Image.asset(
              "assets/icons/setting.png",
              width: screenWidth * .06,
              color: const Color.fromARGB(187, 122, 122, 122),
            ),
          ),
          Gap(screenWidth * .04),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
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
                Gap(screenHeight * .065),

                Container(
                  padding: EdgeInsets.only(left: screenWidth * .03),
                  child: Category(),
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
                BlocBuilder<TaskServiceCubit, TaskServiceState>(
                  builder: (context, state) {
                    if (state is TaskServiceLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TaskServiceloded) {
                      return ListView.builder(
                        key: UniqueKey(),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          var task = state.tasks[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Taskcard(task: task),
                          );
                        },
                      );
                    }
                    return Center(child: Text("No Tasks"));
                  },
                ),
                Gap(screenHeight * .1),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * .04,
            left: screenWidth * .05,
            child: CustomFloatingNavBar(
              currentIndex: selectedIndex,
              onTap: (value) {
                setState(() {
                  selectedIndex = value;
                });
                print("انت دوست على الأيقونة رقم: $value");
              },
            ),
          ),

          Positioned(
            bottom: screenHeight * .14,
            right: screenWidth * .07,
            child: InkWell(
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen()),
                );
                if (result == true) {
                  context.read<TaskServiceCubit>().gettasks();
                }
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff4357D2), Color(0xff2A3EB2)],
                  ),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
          ),

          if (showCard)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubicEmphasized,
              bottom: screenHeight * .15,
              left: screenWidth * .06,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                opacity: cardOpacity,
                child: Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      showCard = false;
                    });
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: screenWidth * 0.88,
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Color.fromARGB(255, 75, 46, 136),
                              Color.fromARGB(255, 179, 154, 226),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Daily $appname",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "“One step at a time is enough for me.”",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: screenHeight * .02),
                            SizedBox(
                              width: screenWidth * .3,
                              height: screenHeight * .04,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xff864CFF),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "READ MORE",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
