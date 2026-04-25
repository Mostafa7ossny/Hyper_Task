import 'package:flutter/material.dart';

class TaskModel {
  final int id;
  final String titletask;
  final String descriptiontask;
  final dynamic? start;
  final dynamic? end;
  final String categorytask;

  TaskModel({
    required this.id,
    required this.titletask,
    required this.descriptiontask,
    required this.start,
    required this.end,
    required this.categorytask,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: int.parse(json['id'].toString()),
      titletask: json['title'],
      descriptiontask: json['description'],
      categorytask: json['type'],
      start: json['start_date'],
      end: json['end_date'],
    );
  }
}
