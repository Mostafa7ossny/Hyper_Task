import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../../constant/Names.dart';
import '../login_cubit/login_cubit.dart';
import '../../../main.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> Signup({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(ApiLink.signuplink),
        body: {"email": email, "username": username, "password": password},
      );

      if (response.statusCode == 200) {
        print("Server Response Body: ${response.body}");
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          sharedpref.setString("id", data['user']['id'].toString());
          sharedpref.setString("email", data['user']['email'].toString());
          sharedpref.setString("username", data['user']['username'].toString());
          emit(SignupSuccess(data['username'] ?? "Signup successful"));
        } else {
          emit(SignupError(data['message'] ?? "Signup failed"));
        }
      } else {
        emit(SignupError("Server error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(SignupError("$e"));
    }
  }
}
