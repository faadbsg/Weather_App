import 'package:weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class GetWeather implements Usecase<List<WeatherEntity>, void> {
  final WeatherRepository repositoryWeather;

  GetWeather({required this.repositoryWeather});
  @override
  Future<Either<Failure, List<WeatherEntity>>> call([void p]) async {
    return await repositoryWeather.getWeather();
  }
}
