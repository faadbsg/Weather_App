part of 'weather_app_cubit.dart';

abstract class WeatherAppState extends Equatable {
  const WeatherAppState();

  @override
  List<Object> get props => [];
}

class WeatherAppInitial extends WeatherAppState {}

class WeatherLoadingState extends WeatherAppState {}

class WeatherLoadedState extends WeatherAppState {
  final List<WeatherEntity> weatherList;
  final String username;

  const WeatherLoadedState({
    required this.weatherList,
    required this.username,
  });
}

class WeatherLoginErrorState extends WeatherAppState {
  final String errorLogin;

  const WeatherLoginErrorState({required this.errorLogin});
}

class WeatherErrorState extends WeatherAppState {
  final String errorWeather;

  const WeatherErrorState({required this.errorWeather});
}
