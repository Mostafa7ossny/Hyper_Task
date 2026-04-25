import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:hyper_task/constant/taskmodel.dart';
import 'package:hyper_task/cubit/screens/task/task_service_cubit.dart';
import 'package:hyper_task/widgets/textfieldtask.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task; // هنا بنستقبل التاسكة لو موجودة
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  List<String> taskCategories = [
    "Ongoing",
    "Urgent",
    "Work",
    "Personal",
    "Other",
  ];

  String? selectedCategory;
  DateTime? startDate;
  DateTime? endDate;

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ليه عملنا كدة؟ عشان لو فيه تاسكة مبعوثة نملا البيانات فوراً
    if (widget.task != null) {
      title.text = widget.task!.titletask ?? "";
      desc.text = widget.task!.descriptiontask ?? "";
      selectedCategory = widget.task!.categorytask;

      // تحويل الـ String اللي جاي من الداتا بيز لتاريخ عشان يظهر في الـ UI
      if (widget.task!.start != null)
        startDate = DateTime.tryParse(widget.task!.start!);
      if (widget.task!.end != null)
        endDate = DateTime.tryParse(widget.task!.end!);
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      // ... نفس الـ builder بتاعك ...
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    // متطيرش عينك، هنا بنحدد العنوان بناءً على حالة الصفحة
    String appBarTitle = widget.task == null ? "ADD TASK" : "EDIT TASK";
    String buttonText = widget.task == null ? "CREATE TASK" : "SAVE CHANGES";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // ... التنسيق بتاعك ...
        title: Text(appBarTitle), // هيتغير لوحده
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(screenHeight * 0.03),

            Container(
              padding: EdgeInsets.only(left: screenWidth * .05),
              width: screenWidth * 1,
              child: Textfieldtask(
                lines: 1,
                colorupper: const Color.fromARGB(255, 0, 114, 120),
                upperfontsize: screenWidth * .04,
                hintcolor: const Color.fromARGB(255, 128, 128, 128),
                hintText: "Enter Your Task",
                uppertitle: 'Task Title',
                mycontroller: title,
              ),
            ),
            Gap(screenHeight * 0.02),

            Container(
              padding: EdgeInsets.only(left: screenWidth * .05),
              width: screenWidth * 1,
              child: Textfieldtask(
                lines: 4,
                hintcolor: const Color.fromARGB(255, 128, 128, 128),
                colorupper: const Color.fromARGB(255, 0, 114, 120),
                upperfontsize: screenWidth * .04,
                hintText: "Enter Task Description",
                uppertitle: 'Description',
                mycontroller: desc,
              ),
            ),
            Gap(screenHeight * 0.02),

            Row(
              children: [
                Gap(screenWidth * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontSize: screenWidth * 0.037,
                            color: const Color.fromARGB(255, 0, 114, 120),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(
                        screenHeight * 0.005,
                      ), // قللت الـ Gap شوية عشان التناسق
                      GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.065,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF0074D4).withOpacity(0.5),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            startDate == null
                                ? "Start Date"
                                : formatDate(startDate!, [
                                    dd,
                                    ' ',
                                    M,
                                    ', ',
                                    yyyy,
                                  ]),
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: startDate == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(screenWidth * 0.04), // مسافة بين العمودين
                // 2. العمود التاني برضه جوه Expanded عشان التساوي
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          'End',
                          style: TextStyle(
                            fontSize: screenWidth * 0.037,
                            color: const Color.fromARGB(255, 0, 114, 120),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(screenHeight * 0.005),
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.065,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF0074D4).withOpacity(0.5),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            endDate == null
                                ? "End Date"
                                : formatDate(endDate!, [
                                    dd,
                                    ' ',
                                    M,
                                    ', ',
                                    yyyy,
                                  ]),
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: endDate == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(screenWidth * 0.05),
              ],
            ),
            Gap(screenHeight * 0.04),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: screenWidth * .02),
                    child: const Text(
                      "Task Category",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 114, 120),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      hintText: "Select Category",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(
                            255,
                            0,
                            116,
                            212,
                          ).withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(
                            255,
                            0,
                            116,
                            212,
                          ).withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: const Color.fromARGB(
                        255,
                        0,
                        116,
                        212,
                      ).withOpacity(0.5),
                    ),
                    items: taskCategories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Gap(screenHeight * 0.04),

            Container(
              padding: EdgeInsets.only(left: screenWidth * .06),
              width: screenWidth * .92,
              child: InkWell(
                onTap: () async {
                  if (title.text.isEmpty ||
                      desc.text.isEmpty ||
                      startDate == null ||
                      endDate == null) {
                    print("في بيانات ناقصة");
                    return;
                  }

                  String sDate =
                      "${startDate!.year}-${startDate!.month}-${startDate!.day}";
                  String eDate =
                      "${endDate!.year}-${endDate!.month}-${endDate!.day}";

                  if (widget.task == null) {
                    // 1. لو التاسك null يبقى بنضيف جديد
                    await context.read<TaskServiceCubit>().addtask(
                      title: title.text,
                      desc: desc.text,
                      start: sDate,
                      end: eDate,
                      type: selectedCategory ?? "Ongoing",
                    );
                  } else {
                    await context.read<TaskServiceCubit>().updatetask(
                      id: widget.task!.id,
                      title: title.text,
                      desc: desc.text,
                      start: sDate,
                      end: eDate,
                      type: selectedCategory ?? "Ongoing",
                    );
                  }

                  Navigator.pop(context, true);
                },
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.07,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 149, 149, 149),
                        Color.fromARGB(255, 179, 210, 248),
                      ],
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
