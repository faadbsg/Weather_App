import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/features/weather/domain/usecase/get_weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.getWeather}) : super(WeatherInitialState()) {
    launchWeatherRequest();
  }

  final GetWeather getWeather;

  Future<void> launchWeatherRequest() async {
    emit(WeatherLoadingState());
    final weatherOrFailure = await getWeather.call();
    weatherOrFailure.fold(
      (failure) => emit(WeatherErrorState(errorWeather: failure.errorMsg)),
      (weather) => emit(WeatherLoadedState(
        weatherList: weather,
      )),
    );
  }
}
