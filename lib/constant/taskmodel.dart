import 'package:flutter/material.dart';

class TaskModel {
  final String titletask;
  final String descriptiontask;
  final String timetask;
  final String categorytask; // مثلاً Work أو Health

  TaskModel({
    required this.titletask,
    required this.descriptiontask,
    required this.timetask,
    required this.categorytask,
  });
}

List<TaskModel> tasksList = [
  TaskModel(
    titletask: "Design Review",
    descriptiontask: "Sync with the UI team about the new flow.",
    timetask: "10:00 AM",
    categorytask: "WORK",
  ),
  TaskModel(
    titletask: "Yoga Session",
    descriptiontask: "Morning flow at the local studio.",
    timetask: "07:30 AM",
    categorytask: "HEALTH",
  ),
  TaskModel(
    titletask: "Project Meeting",
    descriptiontask: "Discuss the milestones with the client.",
    timetask: "02:00 PM",
    categorytask: "WORK",
  ),
  TaskModel(
    titletask: "Project Meeting",
    descriptiontask: "Discuss the milestones with the client.",
    timetask: "02:00 PM",
    categorytask: "WORK",
  ),
  TaskModel(
    titletask: "Project Meeting",
    descriptiontask: "Discuss the milestones with the client.",
    timetask: "02:00 PM",
    categorytask: "WORK",
  ),
];

class InProgresstask {
  final String title;
  final String category;
  final IconData icon;

  InProgresstask({
    required this.title,
    required this.category,
    required this.icon,
  });
}

List<InProgresstask> myprogreesTasks = [
  InProgresstask(
    title: "Gym Workout",
    category: "Health",
    icon: Icons.fitness_center,
  ),
  InProgresstask(title: "Flutter Coding", category: "Work", icon: Icons.code),
  InProgresstask(
    title: "Buy Groceries",
    category: "Personal",
    icon: Icons.shopping_cart,
  ),
];
