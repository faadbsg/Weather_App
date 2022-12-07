import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';

class WeatherModel {
  final String dateModel;
  final double weatherDayModel;
  final String weatherIconModel;
  final String weatherDescritpionModel;

  WeatherModel({
    required this.dateModel,
    required this.weatherDayModel,
    required this.weatherIconModel,
    required this.weatherDescritpionModel,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      dateModel: json['dt_txt'] as String,
      weatherDayModel: json['main']['temp'] as double,
      weatherIconModel: json['weather'][0]['icon'] as String,
      weatherDescritpionModel: json['weather'][0]['description'] as String,
    );
  }

  WeatherEntity toWeatherEntity() {
    return WeatherEntity(
      date: dateModel,
      weatherDay: weatherDayModel,
      weatherIcon: weatherIconModel,
      weatherDescritpion: weatherDescritpionModel,
    );
  }
}
