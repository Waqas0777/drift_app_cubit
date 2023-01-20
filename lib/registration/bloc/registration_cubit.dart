import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fluttertoast/fluttertoast.dart';
import '../../database/app_db.dart';
import '../../main.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitialState());

  void submittedData(context, String userName, String firstName,
      String lastName, String email, String password) {
    // emit(RegistrationLoadingState());
    validateUser(context, userName, firstName, lastName, email, password)
        .then((value) async {
      if (value) {
        //emit(RegistrationLoadingState());
         emit(RegistrationSuccessState());
        // Future.delayed(const Duration(seconds: 2), () async {
        //   //getAllEmployees();
        //   // getIt<AppDb>().getEmployees.listen((event) { });
        // });
      } else {
       // emit(RegistrationLoadingState());
        emit(RegistrationErrorState());

        // Future.delayed(const Duration(seconds: 2), () {
        // });
      }
    }).onError((error, stackTrace) {
      emit(RegistrationErrorState());
    });
  }

  Future<bool> validateUser(
    context,
    String userName,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userName.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return Future.value(false);
    } else {
      final entity = EmployeeCompanion(
        userName: drift.Value(userName),
        firstName: drift.Value(firstName),
        lastName: drift.Value(lastName),
        userEmail: drift.Value(email),
        password: drift.Value(password),
      );
      // if()
      getIt<AppDb>().insertEmployee(entity).then((value) {
        Fluttertoast.showToast(
            msg: "Record Added Successfully",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pop(context);
      });

      return Future.value(true);
    }
  }
}
