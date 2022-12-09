import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entity/weather_entity.dart';

class WeatherResultList extends StatelessWidget {
  final List<WeatherEntity> weatherList;
  final VoidCallback onRefresh;

  const WeatherResultList({
    super.key,
    required this.weatherList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    final String dateRetrieved = DateFormat("dd/MM - HH:mm:ss").format(dateNow);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Paris weather retrieved at:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              dateRetrieved,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: weatherList.length,
                itemBuilder: (_, index) {
                  return _WeatherCard(
                    weather: weatherList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
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

String getDate() {
  final dateRetrieve = DateTime.now();
  final formattedDate = DateFormat("dd/MM - HH:mm").format(dateRetrieve);
  return formattedDate;
}
