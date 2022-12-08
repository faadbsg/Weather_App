import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/presentation/cubit/login_cubit.dart';
import 'package:weather_app/features/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/presentation/page/weather_page.dart';
import 'package:weather_app/features/presentation/widgets/login_widget.dart';
import 'package:weather_app/injection_container.dart' as di;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String nameUser = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
        title: const Text(
          'LOGIN',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            return const LoginWidget();
          } else {
            throw '';
          }
        },
        buildWhen: (previous, current) {
          if (current is LoginErrorState || current is LoginCompletedState) {
            return false;
          }
          return true;
        },
        listener: (parentContext, state) {
          if (state is LoginErrorState) {
            showDialog(
                context: parentContext,
                builder: (context) {
                  return displayAlerError(
                    state.errorMsg,
                    context,
                    (() {
                      parentContext.read<LoginCubit>().goBackLogin();
                    }),
                  );
                });
          }
          if (state is LoginCompletedState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          WeatherCubit(getWeather: di.serviceLocator()),
                      child: WeatherPage(username: state.username),
                    )));
          }
        },
      ),
    );
  }

  Widget displayAlerError(
      String stateError, BuildContext context, VoidCallback onOKPressed) {
    return AlertDialog(
      title: Text(stateError),
      actions: [
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            onOKPressed();
            // context.read<LoginCubit>().goBackLogin();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
