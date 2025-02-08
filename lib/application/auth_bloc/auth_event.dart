part of 'auth_bloc.dart';

@immutable
abstract class AuthEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvents {
  final String email;
  final String pwd;

  LoginEvent({required this.email, required this.pwd});
}

class RegisterEvent extends AuthEvents {
  final String email;
  final String pwd;

  RegisterEvent({required this.email, required this.pwd});
}

class ForgotPasswordEvent extends AuthEvents {
  final String email;

  ForgotPasswordEvent({required this.email});
}

class CreateUserProfileEvent extends AuthEvents {
  final String email;
  final String name;
  final String docID;

  CreateUserProfileEvent(
      {required this.email, required this.name, required this.docID});
}
