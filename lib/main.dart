import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_ai/core/bloc_observer/bloc_observer.dart';
import 'package:flutter_weather_ai/feature/Authentication/data/repo/fire_base_repo.dart';

import 'package:flutter_weather_ai/feature/auth/viewmodel/auth_view_model.dart';
import 'package:flutter_weather_ai/feature/splach/splach_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_weather_ai/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authRepo = FireBaseAppUserRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplachView(),
      ),
    );
  }
}
//class MyApp extends StatelessWidget {
  //final authRepo = FireBaseAppUserRepo();
 // MyApp({super.key});

 // @override
 // Widget build(BuildContext context) {
   // return BlocProvider(
    //  create: (context) => AuthCubit(appUserRepo: authRepo)..checkAuth(),
     // child: MaterialApp(
      // debugShowCheckedModeBanner: false,
       // home: SplachView(),
     // ),
    //);
 // }
//}

