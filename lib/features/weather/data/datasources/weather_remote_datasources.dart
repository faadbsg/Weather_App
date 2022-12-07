import 'dart:convert';

import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/features/weather/data/model/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSources {
  Future<List<WeatherModel>> getWeather();
}

class WeatherRemoteDataSourcesImpl implements WeatherRemoteDataSources {
  final http.Client client;

  WeatherRemoteDataSourcesImpl({required this.client});

  @override
  Future<List<WeatherModel>> getWeather() async {
    final url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=Paris&appid=dee289b80fdd49885faa859de577449d');
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final responsejSon = json.decode(response.body);
      final jsonResList = responsejSon['list'] as List<dynamic>;
      final jsonResModels = jsonResList
          .map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final resultModelsFiltrated = jsonResModels
          .where((element) => element.dateModel.contains('15'))
          .toList();
      return resultModelsFiltrated;
    } else {
      throw ServerException();
    }
  }
}
