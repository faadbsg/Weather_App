import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String date;
  final double temperatureCelsius;
  final String iconCode;
  final String weatherDescritpion;

  const WeatherEntity({
    required this.date,
    required this.temperatureCelsius,
    required this.iconCode,
    required this.weatherDescritpion,
  });

  @override
  List<Object?> get props => [date, temperatureCelsius, iconCode];
}
