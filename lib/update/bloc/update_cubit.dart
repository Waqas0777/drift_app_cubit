import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_db.dart';
import '../../main.dart';
part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitialState());

  //final int id;
  void updateData(context, int id, String userName, String firstName,
      String lastName, String email, String password) {
    // emit(RegistrationLoadingState());
    validateUser(context, id, userName, firstName, lastName, email, password)
        .then((value) async {
      if (value) {
        Navigator.pop(context);
        emit(UpdateSuccessState());
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          emit(UpdateErrorState());
        });
      }
    }).onError((error, stackTrace) {
      emit(UpdateErrorState());
    });
  }
  //Future.delayed(const Duration(seconds: 2), () async {// });

  Future<bool> validateUser(
    context,
    int id,
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
        id: drift.Value(id),
        userName: drift.Value(userName),
        firstName: drift.Value(firstName),
        lastName: drift.Value(lastName),
        userEmail: drift.Value(email),
        password: drift.Value(password),
      );

      getIt<AppDb>().updateEmployee(entity).then((value) =>
          Fluttertoast.showToast(
              msg: "Employee updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0));

      return Future.value(true);
    }
  }
}
