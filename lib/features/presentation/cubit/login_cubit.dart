import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/auth/domain/usecases/get_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.getLogin}) : super(LoginInitialState());

  final GetLogin getLogin;

  Future<void> launchConnection(String email, String password) async {
    final connectedOrFailed = await getLogin.call(
      Param(emailLogin: email, passwordLogin: password),
    );
    connectedOrFailed.fold(
      (failedConnection) =>
          emit(LoginErrorState(errorMsg: failedConnection.errorMsg)),
      (connected) => emit(LoginCompletedState(username: connected.userName)),
    );
  }

  Future<void> goBackLogin() async {
    emit(LoginInitialState());
  }
}
