import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasources.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final NetworkInfo networkInfo;
  final WeatherRemoteDataSources remoteDataSourcesWeather;

  WeatherRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourcesWeather,
  });

  @override
  Future<Either<Failure, List<WeatherEntity>>> getWeather() async {
    if (await networkInfo.isConnected) {
      try {
        final weatherModel = await remoteDataSourcesWeather.getWeather();
        final weatherListEntity =
            weatherModel.map((e) => e.toWeatherEntity()).toList();
        return Right(weatherListEntity);
      } on ServerException {
        return const Left(ServerFailure(errorMsg: 'Server Failed'));
      }
    } else {
      return const Left(ConnectionFailure(errorMsg: 'Connection Failed'));
    }
  }
}
