import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';

import '../entity/auth_user_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, AuthUserEntity>> getLogin(
      String email, String password);
}
