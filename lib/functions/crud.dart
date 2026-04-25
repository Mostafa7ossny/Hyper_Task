import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hyper_task/constant/Names.dart';

class Curd {
  Future<dynamic> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error${response.statusCode}");
      }
    } catch (e) {
      print("error catch$e");
    }
  }

  Future<dynamic> postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      print("===== رد السيرفر =====");
      print(response.body);
      print("======================");
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error${response.statusCode}");
      }
    } catch (e) {
      print("error catch$e");
    }
  }
}

class TaskService {
  final String baseUrl = "${ApiLink.serverlink}";

  Future<List> getTasks() async {
    final response = await http.get(Uri.parse("$baseUrl/get_tasks.php"));

    return jsonDecode(response.body);
  }

  // ➕ ADD
  Future<void> addTask(
    String title,
    String category,
    String description,
    dynamic time,
  ) async {
    await http.post(
      Uri.parse("$baseUrl/add_task.php"),
      body: {
        
        "title": title,
        "category": category,
        "description": description,
        "time": time.toString(),
      },
    );
  }

  // ✏️ UPDATE
  Future<void> updateTask(
    int id,
    String title,
    String category,
    String description,
    dynamic time,
  ) async {
    await http.post(
      Uri.parse("$baseUrl/update_task.php"),
      body: {
        "id": id.toString(),
        "title": title,
        "description": description,
        "type": category,
        "time": time.toString(),
      },
    );
  }

  // ❌ DELETE
  Future<void> deleteTask(int id) async {
    await http.post(
      Uri.parse("$baseUrl/delete_task.php"),
      body: {"id": id.toString()},
    );
  }
}
