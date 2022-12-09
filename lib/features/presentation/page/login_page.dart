import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/presentation/cubit/login_cubit.dart';
import 'package:weather_app/features/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/presentation/page/weather_page.dart';
import 'package:weather_app/features/presentation/widgets/login_widget.dart';
import 'package:weather_app/features/weather/domain/usecase/get_weather.dart';
import 'package:weather_app/injection_container.dart' as di;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Log in',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return const LoginWidget();
        },
        buildWhen: (previous, current) {
          if (current is LoginErrorState || current is LoginCompletedState) {
            return false;
          }
          return true;
        },
        listener: (parentContext, state) {
          if (state is LoginErrorState) {
            _showErrorLogin(parentContext, state);
          }
          if (state is LoginCompletedState) {
            _goToWeatherPage(context, state);
          }
        },
      ),
    );
  }

  Future<void> _showErrorLogin(
      BuildContext parentContext, LoginErrorState state) {
    return showDialog(
        context: parentContext,
        builder: (_) {
          return displayAlerError(
            stateError: state.errorMsg,
            context: parentContext,
            onOKPressed: () {
              parentContext.read<LoginCubit>().resetState();
            },
          );
        });
  }

  void _goToWeatherPage(BuildContext context, LoginCompletedState state) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<WeatherCubit>(
          create: (_) => WeatherCubit(
            getWeather: di.serviceLocator<GetWeather>(),
          ),
          child: WeatherPage(
            username: state.username,
            onLogoutPressed: () {
              context.read<LoginCubit>().resetState();
            },
          ),
        ),
      ),
    );
  }

  Widget displayAlerError({
    required String stateError,
    required BuildContext context,
    required VoidCallback onOKPressed,
  }) {
    return AlertDialog(
      title: Text(stateError),
      actions: [
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            onOKPressed();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
