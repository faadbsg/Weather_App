import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/presentation/cubit/weather_app_cubit.dart';
import 'package:weather_app/features/presentation/widgets/connection_widget.dart';
import 'package:weather_app/features/presentation/widgets/display_error.dart';
import 'package:weather_app/features/presentation/widgets/display_list_weather.dart';
import 'package:weather_app/features/presentation/widgets/loading_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String nameUser = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherAppCubit, WeatherAppState>(
        builder: ((context, state) {
      if (state is WeatherAppInitial) {
        return const ConnectionWidget();
      } else if (state is WeatherLoadingState) {
        return const LoadingWidget();
      } else if (state is WeatherLoadedState) {
        return DisplayListWeather(
            weatherList: state.weatherList, userName: state.username);
      } else if (state is WeatherLoginErrorState) {
        return DisplayError(errorToDisplay: state.errorLogin);
      } else if (state is WeatherErrorState) {
        return DisplayError(errorToDisplay: state.errorWeather);
      } else {
        throw '';
      }
    }));
  }
}
