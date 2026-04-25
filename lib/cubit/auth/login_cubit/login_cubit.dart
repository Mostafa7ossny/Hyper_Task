import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../../constant/Names.dart';
import '../../../main.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      var respone = await http.post(
        Uri.parse(ApiLink.loginlink),
        body: {"email": email, "password": password},
      );
      if (respone.statusCode == 200) {
        var data = jsonDecode(respone.body);
        if (data['status'] == "success") {
          sharedpref.setString("id", data['user']['id'].toString());
          sharedpref.setString("email", data['user']['email'].toString());
          sharedpref.setString("username", data['user']['username'].toString());

          print("Welcome " + data['user']['username']);
          emit(LoginSuccess(data['user']['username']));
        } else {
          emit(LoginError(data['message'] ?? "Login failed"));
        }
      } else {
        emit(LoginError("Server error: ${respone.statusCode}"));
      }
    } catch (e) {
      emit(LoginError("$e"));
    }
  }
}
