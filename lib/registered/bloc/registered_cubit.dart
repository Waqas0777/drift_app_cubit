import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../database/app_db.dart';
import '../../main.dart';

part 'registered_state.dart';

class RegisteredCubit extends Cubit<RegisteredState> {
  RegisteredCubit() : super(RegisteredInitialState());
  EmployeeData? empModel;

  late Set<EmployeeData> employeeDataSet = {};

  void getAllEmployees() {
    //log("calling getAllEmployees");

    emit(RegisteredLoadingState());

    try {
      //log("try");
      //getIt<AppDb>().getEmployeesList.listen((event) {
      //getIt<AppDb>().getEmployeesWatchSingle.listen((event) {

      getIt<AppDb>().getEmployees.listen((value) async {
        employeeDataSet.clear();
        for (var element in value) {

          log("$element");
         // employeeDataSet.contains(getIt<AppDb>().getEmployees.contains(empModel));
          // if (await getIt<AppDb>().getEmployees.contains(empModel) ) {
          //   return showErrorMessage();
          // } else {
            employeeDataSet.add(EmployeeData(
                id: element.id,
                userName: element.userName,
                firstName: element.firstName,
                lastName: element.lastName,
                userEmail: element.userEmail,
                password: element.password));


        }
        // getAllEmployees();
        emit(RegisteredLoadedState(employeeDataSet));
        log("list length==${employeeDataSet.length}");
        //log("LoadedState");
      });
    } catch (e) {
      log("$e");
      emit(RegisteredErrorState(e.toString()));
    }
  }

  void showErrorMessage() {
    Fluttertoast.showToast(
        msg: "Record is Already in List",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //employee model
  // empModel = EmployeeData(
  // id: element.id,
  // userName: element.userName,
  // firstName: element.firstName,
  // lastName: element.lastName,
  // userEmail: element.userEmail,
  // password: element.password);

// void getWatchSingle(){
//   getIt<AppDb>().getEmployeesWatchSingle.listen((event) {
//     log("event $event");
//     // employeeDataList.clear();
//     // employeeDataList.add(EmployeeData(
//     //     id: event.id,
//     //     userName: event.userName,
//     //     firstName: event.firstName,
//     //     lastName: event.lastName,
//     //     userEmail: event.userEmail,
//     //     password: event.password));
//     // emit(RegisteredLoadedState(employeeDataList));
//     // getAllEmployees();
//   });
// }

}

// getIt<AppDb>().getEmployeesWatchSingle(employeeDataList.length).listen((event) {
//   log("myevent1 $event");
// });

// void deleteEmployee(int id) {
//   showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0)),
//         //this right here
//         child: SizedBox(
//           height: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Are You Sure You Want to Delete??",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         getIt<AppDb>().deleteEmployee(id).then((value) =>
//                             Fluttertoast.showToast(
//                                 msg: "Record deleted Successfully",
//                                 backgroundColor: Colors.red,
//                                 gravity: ToastGravity.BOTTOM));
//                         // setState(() {});
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         width: 100,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: Colors.red,
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "Yes",
//                             style: TextStyle(
//                                 fontSize: 17, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         width: 100,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: Colors.green,
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "No",
//                             style: TextStyle(
//                                 fontSize: 17, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ));
// }
