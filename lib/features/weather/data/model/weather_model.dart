import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';

class WeatherModel {
  final String date;
  final double kelvinTemperature;
  final String weatherIconCode;
  final String weatherDescritpion;

  WeatherModel({
    required this.date,
    required this.kelvinTemperature,
    required this.weatherIconCode,
    required this.weatherDescritpion,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['dt_txt'] as String,
      kelvinTemperature: (json['main']['temp'] as num).toDouble(),
      weatherIconCode: json['weather'][0]['icon'] as String,
      weatherDescritpion: json['weather'][0]['description'] as String,
    );
  }

  WeatherEntity toWeatherEntity() {
    final dateParsed = DateTime.parse(date);
    final formatedDate = DateFormat('dd/MM HH:mm').format(dateParsed);
    final tempKelvinToCelsius = kelvinTemperature - 273.15;
    return WeatherEntity(
      date: formatedDate,
      temperatureCelsius: tempKelvinToCelsius,
      iconCode: weatherIconCode,
      weatherDescritpion: weatherDescritpion,
    );
  }
}
