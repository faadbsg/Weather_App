import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMsg;

  const Failure({required this.errorMsg});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class LoginFailure extends Failure {
  const LoginFailure({required super.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
