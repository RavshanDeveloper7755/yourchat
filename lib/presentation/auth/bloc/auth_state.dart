part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class HomeInitial extends AuthState {
  @override
  List<Object> get props => [];
}
