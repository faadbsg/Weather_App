import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String date;
  final double weatherDay;
  final String weatherIcon;
  final String weatherDescritpion;

  const WeatherEntity({
    required this.date,
    required this.weatherDay,
    required this.weatherIcon,
    required this.weatherDescritpion,
  });

  @override
  List<Object?> get props => [date, weatherDay, weatherIcon];
}
