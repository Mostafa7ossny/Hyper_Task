import 'package:flutter/material.dart';
import 'package:hyper_task/constant/taskmodel.dart';

class Inprogresstask extends StatelessWidget {
  const Inprogresstask({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // مهم لو هتحطها جوه Column
      physics: NeverScrollableScrollPhysics(), // لو الـ Scroll شغال من بره
      itemCount: myprogreesTasks.length, // عدد العناصر في الليستة
      itemBuilder: (context, index) {
        // index هو رقم العنصر اللي عليه الدور في الرسم
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.withOpacity(0.1),
              child: Icon(
                myprogreesTasks[index].icon,
                color: Colors.deepPurple,
              ),
            ),
            title: Text(
              myprogreesTasks[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(myprogreesTasks[index].category),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print("دُست على: ${myprogreesTasks[index].title}");
            },
          ),
        );
      },
    );
  }
}
