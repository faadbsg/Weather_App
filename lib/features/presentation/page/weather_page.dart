import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/presentation/cubit/login_cubit.dart';
import 'package:weather_app/features/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/presentation/widgets/display_list_weather.dart';
import 'package:weather_app/features/presentation/widgets/loading_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.username});
  final String username;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        centerTitle: true,
        title: Text(
          'Welcome ${widget.username}',
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.grey[300],
            ),
            onPressed: () {
              Provider.of<LoginCubit>(context, listen: false).goBackLogin();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: ((context, state) {
            if (state is WeatherErrorState) {
              showDialog(
                context: context,
                builder: ((context) {
                  return displayAlerError(state);
                }),
              );
            }
          }),
          buildWhen: (previous, current) {
            if (current is WeatherErrorState) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return const SizedBox.shrink();
            } else if (state is WeatherLoadingState) {
              return const LoadingWidget();
            } else if (state is WeatherLoadedState) {
              return DisplayListWeather(weatherList: state.weatherList);
            } else {
              throw '';
            }
          },
        ),
      ),
    );
  }
}

AlertDialog displayAlerError(WeatherErrorState state) {
  return AlertDialog(
    title: Text(state.errorWeather),
    actions: [
      ElevatedButton(
        child: const Text('OK'),
        onPressed: () {
          //appel méthode cubit pour retour login page
        },
      ),
    ],
  );
}
