import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/features/auth/data/model/user_auth_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserAuthModel> getLogin(String email, String password);
}

class LoginRemoteDataSourcesImpl implements LoginRemoteDataSource {
  @override
  Future<UserAuthModel> getLogin(String email, String password) async {
    if ((email == 'test@test.com') && (password == 'test')) {
      return UserAuthModel(
        emailModel: 'test@test.com',
        passwordModel: 'test',
        usernameModel: 'Harry',
      );
    } else {
      throw LoginException();
    }
  }
}
