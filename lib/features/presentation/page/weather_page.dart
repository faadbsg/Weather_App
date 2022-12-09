import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/presentation/cubit/login_cubit.dart';
import 'package:weather_app/features/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/presentation/widgets/weather_result_list.dart';
import 'package:weather_app/features/presentation/widgets/loading_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    super.key,
    required this.username,
    required this.onLogoutPressed,
  });
  final String username;
  final VoidCallback onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          'Welcome $username',
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
              Provider.of<LoginCubit>(context, listen: false).resetState();
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
                  return _buildAlertDialog(state: state, context: context);
                }),
              );
            }
          }),
          buildWhen: (_, current) {
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
              return WeatherResultList(
                weatherList: state.weatherList,
                onRefresh: () {
                  context.read<WeatherCubit>().fetchWeather();
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  AlertDialog _buildAlertDialog(
      {required WeatherErrorState state, required BuildContext context}) {
    return AlertDialog(
      title: Text(state.errorWeather),
      actions: [
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            onLogoutPressed();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
