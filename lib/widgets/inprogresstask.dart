// import 'package:flutter/material.dart';
// import '../constant/taskmodel.dart';

// class Inprogresstask extends StatelessWidget {
//   const Inprogresstask({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true, 
//       physics: NeverScrollableScrollPhysics(), 
//       itemCount: myprogreesTasks.length, 
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.deepPurple.withOpacity(0.1),
//               child: Icon(
//                 myprogreesTasks[index].icon,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             title: Text(
//               myprogreesTasks[index].title,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(myprogreesTasks[index].category),
//             trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//             onTap: () {
//               print("دُست على: ${myprogreesTasks[index].title}");
//             },
//           ),
//         );
//       },
//     );
//   }
// }
