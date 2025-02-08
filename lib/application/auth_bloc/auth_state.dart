part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoggedIn extends AuthState {
  final String userID;

  const LoggedIn(this.userID);
}

class Registered extends AuthState {
  final String userID;

  const Registered(this.userID);
}

class ResetPwdEmailSent extends AuthState {
  const ResetPwdEmailSent();
}

class UserProfileCreated extends AuthState {
  const UserProfileCreated();
}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);
}
