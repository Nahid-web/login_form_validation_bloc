import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation_bloc/bloc/auth_bloc.dart';
import 'package:login_form_validation_bloc/login_screen.dart';
import 'package:login_form_validation_bloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text((state as AuthSuccess).uid),
              GradientButton(
                buttonName: 'Log Out',
                onPressed: () {
                context.read<AuthBloc>().add(AuthLogOutRequest());
              }),
            ],
          );
        },
      ),
    );
  }
}
