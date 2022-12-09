import 'package:weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/auth/domain/entity/auth_user_entity.dart';
import 'package:weather_app/features/auth/domain/repository/login_repository.dart';

class GetLogin implements Usecase<AuthUserEntity, Param> {
  final LoginRepository repositoryLogin;

  GetLogin({required this.repositoryLogin});

  @override
  Future<Either<Failure, AuthUserEntity>> call(param) async {
    return await repositoryLogin.getLogin(param.email, param.password);
  }
}

class Param {
  final String email;
  final String password;

  Param({required this.email, required this.password});
}
