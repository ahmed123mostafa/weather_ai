import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/feature/Authentication/presentation/view/login_view.dart';
import 'package:flutter_weather_ai/feature/auth/view/pages/widget/Auth_form.dart';
import 'package:flutter_weather_ai/feature/auth/viewmodel/auth_view_model.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/home_screen.dart';

import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_day_weather.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: null,
        iconTheme: IconThemeData(color: Colors.white),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: AuthForm(
        emailController: emailController,
        passwordController: passwordController,
        isSignUp: false,
        onSubmit: () async {
          try {
            await authViewModel.signIn(
              emailController.text,
              passwordController.text,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              (Route<dynamic> route) => false,
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
