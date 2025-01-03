part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String userName;
  final String designation;
  final String email;
  final String userPhoneNumber;
  final String password;
  final String department;

  AuthSignUp({
    required this.userName,
    required this.designation,
    required this.email,
    required this.userPhoneNumber,
    required this.password,
    required this.department,
  });
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({
    required this.email,
    required this.password,
  });
}

final class AuthIsUserSignIn extends AuthEvent{}
