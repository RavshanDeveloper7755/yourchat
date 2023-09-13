part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginWithEmailEvent extends AuthEvent{
  final String email;
  final String password;
  const LoginWithEmailEvent({required this.email,required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}


class SignUpEvent extends AuthEvent{
  final String email;
  final String password;
  final String name;
  const SignUpEvent({required this.name,required this.email,required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password];
}

class GoogleEvent extends AuthEvent{
  const GoogleEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}