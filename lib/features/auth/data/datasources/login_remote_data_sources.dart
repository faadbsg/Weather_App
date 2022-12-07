import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/features/auth/data/model/user_auth_model.dart';

abstract class LoginRemoteDataSources {
  Future<UserAuthModel> getLogin(String email, String password);
}

class LoginRemoteDataSourcesImpl implements LoginRemoteDataSources {
  @override
  Future<UserAuthModel> getLogin(String email, String password) async {
    if ((email == 'harrypotter@test.com') && (password == 'test')) {
      return UserAuthModel(
        emailModel: 'harrypotter@test.com',
        passwordModel: 'test',
        usernameModel: 'Harry',
      );
    } else {
      throw LoginException();
    }
  }
}