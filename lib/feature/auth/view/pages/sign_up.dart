import 'package:flutter/material.dart';

import 'package:flutter_weather_ai/feature/auth/view/pages/widget/Auth_form.dart';
import 'package:flutter_weather_ai/feature/auth/view/pages/widget/dialog.dart';
import 'package:flutter_weather_ai/feature/auth/viewmodel/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

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
        firstNameController: firstNameController,
        lastNameController: lastNameController,
        isSignUp: true,
        onSubmit: () async {
          try {
            await authViewModel.signUp(
              firstNameController.text,
              lastNameController.text,
              emailController.text,
              passwordController.text,
            );
            showCustomCelebrationDialog(context,
                "${firstNameController.text} ${lastNameController.text}");
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
