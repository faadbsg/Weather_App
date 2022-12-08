import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';

class DisplayListWeather extends StatelessWidget {
  final List<WeatherEntity> weatherList;

  const DisplayListWeather({
    super.key,
    required this.weatherList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: weatherList.length,
          itemBuilder: ((context, index) {
            return _WeatherCard(
              weather: weatherList[index],
            );
          })),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[300],
      child: ListTile(
        isThreeLine: true,
        leading: SizedBox(
          height: 30,
          width: 30,
          child: CachedNetworkImage(
              imageUrl:
                  'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png'),
        ),
        title: Text(weather.date),
        subtitle: Text(
            "${weather.temperatureCelsius.toStringAsFixed(0)} °C - ${weather.weatherDescritpion}"),
      ),
    );
  }
}
