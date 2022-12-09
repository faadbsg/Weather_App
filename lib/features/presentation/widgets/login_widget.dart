import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/presentation/cubit/login_cubit.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool passwordHidden = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: passwordHidden,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: !passwordHidden
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordHidden = !passwordHidden;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                context.read<LoginCubit>().login(
                      _emailController.text,
                      _passwordController.text,
                    );
                _emailController.clear();
                _passwordController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
