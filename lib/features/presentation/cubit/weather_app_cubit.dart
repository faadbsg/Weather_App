import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/auth/domain/usecases/get_login.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/features/weather/domain/usecase/get_weather.dart';

part 'weather_app_state.dart';

class WeatherAppCubit extends Cubit<WeatherAppState> {
  WeatherAppCubit({required this.getWeather, required this.getLogin})
      : super(WeatherAppInitial());

  final GetWeather getWeather;
  final GetLogin getLogin;

  Future<void> launchConnectionThenGetweather(
      String email, String password) async {
    final loginOrFailure = await getLogin.call(Param(
      emailLogin: email,
      passwordLogin: password,
    ));
    loginOrFailure.fold(
      (failure) => emit(WeatherLoginErrorState(errorLogin: failure.errorMsg)),
      (login) async {
        emit(WeatherLoadingState());
        final weatherOrFailure = await getWeather.call();
        weatherOrFailure.fold(
          (failure) => emit(WeatherErrorState(errorWeather: failure.errorMsg)),
          (weather) => emit(WeatherLoadedState(
            weatherList: weather,
            username: login.userName,
          )),
        );
      },
    );
  }

  Future<void> goBackConnection() async {
    emit(WeatherAppInitial());
  }
}
