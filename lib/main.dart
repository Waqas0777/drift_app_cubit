import 'package:drift_app_cubit/registered/bloc/registered_cubit.dart';
import 'package:drift_app_cubit/registered/view/registered_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'database/app_db.dart';


void main() async {
  runApp(const MyApp());
  await initDependencyInjection();
}

Future<void> initDependencyInjection() async {
  getIt.registerSingleton<AppDb>(AppDb());
}

final getIt = GetIt.instance;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisteredCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const RegisteredEmployeesScreen(),
      ),
    );
  }
}
