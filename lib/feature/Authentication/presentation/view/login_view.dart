import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_ai/core/botton/custom_botton.dart';
import 'package:flutter_weather_ai/core/style/app_style.dart';
import 'package:flutter_weather_ai/core/validator/validator.dart';
import 'package:flutter_weather_ai/feature/Authentication/presentation/manager/cubit/auth_cubit_cubit.dart';
import 'package:flutter_weather_ai/feature/Authentication/presentation/view/register_screen.dart';
import 'package:flutter_weather_ai/feature/Authentication/presentation/view/widget/custom_form_field.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/home_screen.dart';
import 'package:flutter_weather_ai/feature/home/presentation/view/widget/custom_day_weather.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailcontrroler;
  late TextEditingController passwordcontrroler;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    emailcontrroler = TextEditingController();
    passwordcontrroler = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Form(
          key: formkey,
          child: BlocConsumer<AuthCubit, AuthCubitState>(
            listener: (context, state) {
              if (state is AuthCubitLoading) {
                //show loading
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              } else if (state is AuthCubitFail) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    content: Text(state.errmessage),
                  ),
                );
              } else if (state is AuthCubitSuccess) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    // Todo : replace text content with the home screen
                    content: Text(
                      "Welcome, ${state.user.name}!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>HomeView ()));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Text(
                        "Welcome back!\n Again!",
                        style: AppStyle.primarystyle,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReusableInputField(
                        controller: emailcontrroler,
                        labelText: "enter your Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail),
                    SizedBox(
                      height: 15,
                    ),
                    ReusableInputField(
                        controller: passwordcontrroler,
                        labelText: "Enter your password",
                        keyboardType: TextInputType.text,
                        validator: Validators.validatePassword),
                    SizedBox(
                      height: 12,
                    ),
                    ReusableButton(
                        text: "Login",
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                                email: emailcontrroler.text.trim(),
                                password: passwordcontrroler.text.trim());
                          }
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text("Don’t have an account?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ))),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text("RigesterNow",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
