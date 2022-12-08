part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final List<WeatherEntity> weatherList;

  const WeatherLoadedState({
    required this.weatherList,
  });
  @override
  List<Object> get props => [weatherList];
}

class WeatherLoginErrorState extends WeatherState {
  final String errorLogin;

  const WeatherLoginErrorState({required this.errorLogin});
  @override
  List<Object> get props => [errorLogin];
}

class WeatherErrorState extends WeatherState {
  final String errorWeather;

  const WeatherErrorState({required this.errorWeather});
  @override
  List<Object> get props => [errorWeather];
}
