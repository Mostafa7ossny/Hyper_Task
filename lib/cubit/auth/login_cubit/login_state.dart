part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  late final String username;
  LoginSuccess(this.username);
}

final class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}
