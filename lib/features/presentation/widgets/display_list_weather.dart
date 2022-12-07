import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';

class DisplayListWeather extends StatelessWidget {
  final String userName;
  final List<WeatherEntity> weatherList;

  const DisplayListWeather({
    super.key,
    required this.userName,
    required this.weatherList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue $userName'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: weatherList.length,
            itemBuilder: ((context, index) {
              final weatherToCelsius =
                  (weatherList[index].weatherDay - 273.15).toStringAsFixed(2);
              final weatherCelsiusToDisplay = '$weatherToCelsius °C';
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.grey,
                child: ListTile(
                  leading: Container(
                    height: 30,
                    width: 30,
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://openweathermap.org/img/wn/${weatherList[index].weatherIcon}@2x.png'),
                  ),
                  title: Text(weatherCelsiusToDisplay),
                  subtitle: Text(weatherList[index].weatherDescritpion),
                ),
              );
            })),
      ),
    );
  }
}
