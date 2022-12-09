// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/auth/domain/usecases/get_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.getLogin}) : super(LoginInitialState());

  final GetLogin getLogin;

  Future<void> login(String email, String password) async {
    final connectedOrFailed = await getLogin.call(
      Param(email: email, password: password),
    );
    connectedOrFailed.fold(
      (failedConnection) =>
          emit(LoginErrorState(errorMsg: failedConnection.errorMsg)),
      (connected) => emit(LoginCompletedState(username: connected.username)),
    );
  }

  Future<void> resetState() async {
    emit(LoginInitialState());
  }
}
