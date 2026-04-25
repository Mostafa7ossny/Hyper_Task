import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hyper_task/constant/Names.dart';
import 'package:hyper_task/main.dart';
import '../../../constant/taskmodel.dart';
import 'package:meta/meta.dart';

part 'task_service_state.dart';

class TaskServiceCubit extends Cubit<TaskServiceState> {
  TaskServiceCubit() : super(TaskServiceInitial());
  List<TaskModel> tasks = [];

  Future<void> gettasks() async {
    // 1. أهم خطوة: فضي اللستة تماماً قبل ما تبدأ أي حاجة
    tasks = [];
    emit(TaskServiceLoading());

    try {
      String? userId = sharedpref.getString("id");

      // ضفنا Timestamp بسيط في اللينك عشان نكسر أي Cache من السيرفر أو الـ HTTP
      var res = await http.get(
        Uri.parse(
          "${ApiLink.getlink}?userid=$userId&t=${DateTime.now().millisecondsSinceEpoch}",
        ),
      );

      var body = jsonDecode(res.body);
      if (body["status"] == "success") {
        List data = body["data"];

        // 2. حول الداتا للستة جديدة تماماً واحقنها في الـ emit
        List<TaskModel> freshTasks = data
            .map((e) => TaskModel.fromJson(e))
            .toList();
        tasks = freshTasks;

        emit(
          TaskServiceloded(List.from(tasks)),
        ); // بنبعت نسخة (Copy) عشان الـ Bloc يحس بالتغيير
      } else {
        tasks = [];
        emit(TaskServiceloded(tasks));
      }
    } catch (e) {
      print("get Error: $e");
      emit(TaskServiceError(e.toString()));
    }
  }

  Future<void> addtask({
    required String title,
    required String desc,
    required String start,
    required String end,
    required String type,
  }) async {
    try {
      String? userId = sharedpref.getString("id");

      var res = await http.post(
        Uri.parse(ApiLink.addlink),
        body: {
          "title": title,
          "description": desc,
          "start_date": start,
          "end_date": end,
          "type": type,
          "user_id": userId,
        },
      );

      var body = jsonDecode(res.body);
      if (body["status"] == "success") {
        await gettasks();
      }
    } catch (e) {
      print("add Error: $e");
      emit(TaskServiceError(e.toString()));
    }
  }

  // 1. Delete Task
  Future<void> deletetask(int taskId) async {
    try {
      var res = await http.post(
        Uri.parse(ApiLink.deletelink), // اتأكد إنك ضفت اللينك في ApiLink
        body: {"id": taskId.toString()},
      );

      if (res.statusCode == 200) {
        var responseBody = jsonDecode(res.body);
        if (responseBody['status'] == "success") {
          print("Task Deleted Successfully");
          gettasks(); // تحديث اللستة بعد الحذف
        }
      }
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  // 2. Edit Task
  Future<void> updatetask({
    required int id,
    required String title,
    required String desc,
    required String start,
    required String end,
    required String type,
  }) async {
    try {
      var res = await http.post(
        Uri.parse(ApiLink.editlink), // اتأكد إنك ضفت اللينك في ApiLink
        body: {
          "id": id.toString(),
          "title": title,
          "description": desc,
          "start_date": start,
          "end_date": end,
          "type": type,
        },
      );

      if (res.statusCode == 200) {
        var responseBody = jsonDecode(res.body);
        print("Server Response: ${res.body}"); // السطر ده هيقولك الـ PHP زعلان من إيه
        if (responseBody['status'] == "success") {
          emit(TaskServiceLoading());
          await gettasks();
        }
      }
    } catch (e) {
      print("Error updating task: $e");
    }
  }
}
