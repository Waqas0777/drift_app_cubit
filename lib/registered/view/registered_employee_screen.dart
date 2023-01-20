import 'dart:developer';

import 'package:drift_app_cubit/registered/bloc/registered_cubit.dart';
import 'package:drift_app_cubit/update/view/update_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../database/app_db.dart';
import '../../main.dart';
import '../../registration/view/employee_registration_screen.dart';

class RegisteredEmployeesScreen extends StatefulWidget {
  const RegisteredEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredEmployeesScreen> createState() =>
      _RegisteredEmployeesScreenState();
}

class _RegisteredEmployeesScreenState extends State<RegisteredEmployeesScreen> {
  //RegisteredCubit? registeredCubit;

  @override
  void initState() {
    // TODO: implement initState
    // registeredCubit = RegisteredCubit();
     //registeredCubit!.getAllEmployees();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Registered Employees"),
        ),
        body: SafeArea(
            child: BlocProvider(
          create: (context) => RegisteredCubit()..getAllEmployees(),
          child: BlocConsumer<RegisteredCubit, RegisteredState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is RegisteredInitialState) {
                return const Center(
                  child: Text("No data added yet"),
                );
              } else if (state is RegisteredLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisteredErrorState) {
                return const Center(
                  child: Text("Error Loading data"),
                );
              } else if (state is RegisteredLoadedState) {
                return ListView.builder(
                    itemCount: state.empList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var listData = state.empList.elementAt(index);
                      //log(state.empList.toString());

                      return Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Text(employee.id.toString()),
                                    Text(listData.userName.toString()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(listData.firstName.toString()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(listData.lastName.toString()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(listData.userEmail.toString()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(listData.password.toString()),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UpdateEmployeeScreen(
                                            id: listData.id,
                                          );
                                        }));
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      )),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        dialogShow(listData.id);
                                        //deleteEmployee(empData[index].id);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                      //   (state.empList.isEmpty)
                      //     ? const Center(
                      //   child: Text("No Data Exist"),
                      // ):
                    });
              } else {
                return const Center(
                  child: Text("Something went wrong!!!"),
                );
              }
            },
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            // Respond to button press
            //MyClass.getWatchSingle();

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const EmployeeRegistrationScreen();
            }));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add'),
        ),
      ),
    );
  }

  void dialogShow(int id) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //this right here
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Are You Sure You Want to Delete??",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              getIt<AppDb>().deleteEmployee(id).then((value) =>
                                  Fluttertoast.showToast(
                                      msg: "Record deleted Successfully",
                                      backgroundColor: Colors.red,
                                      gravity: ToastGravity.BOTTOM));
                              // setState(() {});
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.red,
                              ),
                              child: const Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.green,
                              ),
                              child: const Center(
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
