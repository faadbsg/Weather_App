import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String emailUser;
  final String passwordUser;
  final String userName;

  const AuthUserEntity(this.emailUser, this.passwordUser, this.userName);

  @override
  List<Object?> get props => [emailUser, passwordUser, userName];
}
