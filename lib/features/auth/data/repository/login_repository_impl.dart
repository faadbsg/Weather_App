import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/auth/data/datasources/login_remote_data_sources.dart';
import 'package:weather_app/features/auth/domain/entity/auth_user_entity.dart';
import 'package:weather_app/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, AuthUserEntity>> getLogin(
      String emailLogin, String passwordLogin) async {
    if (await networkInfo.isConnected) {
      try {
        final userloginModel =
            await loginRemoteDataSource.getLogin(emailLogin, passwordLogin);
        final userLogin = userloginModel.toAuthUser();
        return Right(userLogin);
      } on LoginException {
        return const Left(LoginFailure(errorMsg: 'email or password invalid!'));
      }
    } else {
      return const Left(ServerFailure(errorMsg: 'server failed!'));
    }
  }
}
