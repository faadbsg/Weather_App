import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String email;
  final String password;
  final String username;

  const AuthUserEntity(this.email, this.password, this.username);

  @override
  List<Object?> get props => [email, password, username];
}
