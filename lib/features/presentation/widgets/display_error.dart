import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/presentation/cubit/weather_app_cubit.dart';

class DisplayError extends StatelessWidget {
  final String errorToDisplay;
  const DisplayError({super.key, required this.errorToDisplay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: Text(errorToDisplay),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Provider.of<WeatherAppCubit>(context, listen: false)
                    .goBackConnection();
              },
              child: const Text('OK'))
        ],
      ),
    );
  }
}
