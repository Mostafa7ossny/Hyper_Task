import '../main.dart';

String appname = "Hyper Task ";
String get usernameapp => sharedpref.getString("username") ?? "User";
String? idString = sharedpref.getString("id") ?? "0";

int get iduser => int.tryParse(sharedpref.getString("id") ?? "0") ?? 0;
String avtar = "assets/signup/boy.png";

class ApiLink {
  static const String serverlink = "http://10.0.2.2/tasks_app/";
  static const String signuplink = "$serverlink/signup.php";
  static const String loginlink = "$serverlink/login.php";
  static const String getlink = "$serverlink/get_tasks.php";
  static const String addlink = "$serverlink/add_task.php";
  static const String editlink = "$serverlink/edit_task.php";
  static const String deletelink = "$serverlink/delete_task.php";
}
