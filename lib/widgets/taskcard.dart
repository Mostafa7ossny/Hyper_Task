import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:hyper_task/cubit/screens/task/task_service_cubit.dart';
import 'package:hyper_task/screens/add_task.dart';
import '../constant/taskmodel.dart';

class Taskcard extends StatelessWidget {
  final TaskModel task;

  const Taskcard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Slidable(
      key: ValueKey(task.id),

      endActionPane: ActionPane(
        motion: const ScrollMotion(), // شكل الحركة وأنت بتسحب
        extentRatio: 0.5, // المساحة اللي الأزرار هتاخدها من عرض الكارد (50%)
        children: [
          SlidableAction(
            onPressed: (context) async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddTaskScreen(task: task), // بعتنا التاسك هنا
                ),
              );
              if (context.mounted) {
                context.read<TaskServiceCubit>().gettasks();
              }
              print("Edit Task: ${task.id}");
            },
            backgroundColor: const Color.fromARGB(255, 119, 88, 157),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          SlidableAction(
            onPressed: (context) {
              // 1. خزن الـ Cubit في متغير قبل ما تفتح الدايلوج
              final taskCubit = context.read<TaskServiceCubit>();

              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  // لاحظ هنا بنستخدم dialogContext
                  title: const Text("Delete Task"),
                  content: const Text("Are you sure?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        // 2. اقفل الدايلوج الأول باستخدام الـ context بتاعه
                        Navigator.pop(dialogContext);

                        // كدة إنت مش معتمد على الـ context اللي مات
                        taskCubit.deletetask(task.id);
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: screenWidth * 0.9,
          margin: const EdgeInsets.only(
            bottom: 16,
          ), // مسافة بين كل كارد والتاني
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الدائرة اللي على الشمال
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purpleAccent, width: 2),
                ),
              ),
              const SizedBox(width: 16),

              // محتوى الكارد (العنوان، الوصف، التاريخ)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والـ Category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // عشان لو العنوان طويل ميبوظش الشكل
                          child: Text(
                            task.titletask,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            task.categorytask,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // الوصف
                    Text(
                      task.descriptiontask,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 78, 78, 78),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Row التاريخ (البداية والنهاية)
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          task.start ?? "Start Date",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Icon(
                          Icons.event_available_outlined,
                          size: 14,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          task.end ?? "End Date",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
