part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCompletedState extends LoginState {
  final String username;

  const LoginCompletedState({required this.username});
  @override
  List<Object> get props => [username];
}

class LoginErrorState extends LoginState {
  final String errorMsg;

  const LoginErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
