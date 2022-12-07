import 'package:weather_app/features/auth/domain/entity/auth_user_entity.dart';

class UserAuthModel {
  final String emailModel;
  final String passwordModel;
  final String usernameModel;

  UserAuthModel({
    required this.emailModel,
    required this.passwordModel,
    required this.usernameModel,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> map) {
    return UserAuthModel(
      emailModel: map['email'],
      passwordModel: map['password'],
      usernameModel: map['username'],
    );
  }

  AuthUserEntity toAuthUser() {
    return AuthUserEntity(
      emailModel,
      passwordModel,
      usernameModel,
    );
  }
}
