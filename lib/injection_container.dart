import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/auth/data/datasources/login_remote_data_sources.dart';
import 'package:weather_app/features/auth/data/repository/login_repository_impl.dart';
import 'package:weather_app/features/auth/domain/repository/login_repository.dart';
import 'package:weather_app/features/auth/domain/usecases/get_login.dart';
import 'package:weather_app/features/presentation/cubit/login_cubit.dart';
import 'package:weather_app/features/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasources.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecase/get_weather.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Cubits
  serviceLocator.registerFactory(
    () => WeatherCubit(
      getWeather: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(
      getLogin: serviceLocator(),
    ),
  );

  //----------Usescases
  //Weather
  serviceLocator.registerLazySingleton(
      () => GetWeather(repositoryWeather: serviceLocator()));
  //Login
  serviceLocator
      .registerLazySingleton(() => GetLogin(repositoryLogin: serviceLocator()));

  //----------Repository
  //Weather
  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
        networkInfo: serviceLocator(),
        remoteDataSourcesWeather: serviceLocator()),
  );
  //Login
  serviceLocator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        loginRemoteDataSource: serviceLocator(), networkInfo: serviceLocator()),
  );

  //------------Datasources
  //Weather
  serviceLocator.registerLazySingleton<WeatherRemoteDataSources>(
      () => WeatherRemoteDataSourcesImpl(client: serviceLocator()));
  //Login
  serviceLocator.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourcesImpl());

  //------------External
  //Network
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(checker: serviceLocator()));
  //Http
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  //DataConnectionChecker
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
