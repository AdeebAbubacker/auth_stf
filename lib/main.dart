import 'package:authentication/application/auth/auth_bloc.dart';
import 'package:authentication/domain/core/dep_injection/dep_injection.dart';
import 'package:authentication/presentation/login.dart';
import 'package:authentication/presentation/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  await SharedPreferences
      .getInstance(); // Ensure shared_preferences is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: RegsiterPage(),
      ),
    );
  }
}
