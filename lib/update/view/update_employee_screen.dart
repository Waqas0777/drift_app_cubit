import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fluttertoast/fluttertoast.dart';
import '../../database/app_db.dart';
import '../../main.dart';
import '../bloc/update_cubit.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final int id;

  const UpdateEmployeeScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<UpdateEmployeeScreen> createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  late EmployeeData _employeeData;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getEmployee();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   // _appDb.close();
  //   // userNameController.dispose();
  //   // firstNameController.dispose();
  //   // lastNameController.dispose();
  //   // emailController.dispose();
  //   // passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Update Employee"),
        ),
        body: bodyWidget(context),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildFormWidget(),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<UpdateCubit, UpdateState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return CupertinoButton(
                    color: Colors.blue,
                    onPressed: () {
                      //addEmployee();
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<UpdateCubit>(context).updateData(
                            context,
                            widget.id,
                            userNameController.text,
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            passwordController.text);
                      }

                    },
                    child: const Text("Update"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateEmployee() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final entity = EmployeeCompanion(
        id: drift.Value(widget.id),
        userName: drift.Value(userNameController.text),
        firstName: drift.Value(firstNameController.text),
        lastName: drift.Value(lastNameController.text),
        userEmail: drift.Value(emailController.text),
        password: drift.Value(passwordController.text),
      );
      getIt<AppDb>().updateEmployee(entity).then((value) =>
          Fluttertoast.showToast(
              msg: "Employee updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0));
      Navigator.pop(context);
    }
  }

  Widget buildFormWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                } else {
                  return null;
                }
              },
              onChanged: (val) {},
              controller: userNameController,
              decoration: InputDecoration(
                labelText: "Enter Your Username",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter First Name';
                }
                return null;
              },
              controller: firstNameController,
              onChanged: (val) {},
              decoration: InputDecoration(
                labelText: "Enter Your First Name",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Last Name';
                }
                return null;
              },
              controller: lastNameController,
              onChanged: (val) {},
              decoration: InputDecoration(
                labelText: "Enter Your Last Name",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              },
              controller: emailController,
              onChanged: (val) {},
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Enter Your Email",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
              controller: passwordController,
              onChanged: (val) {},
              decoration: InputDecoration(
                labelText: "Enter Your Password",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> getEmployee() async {
    _employeeData = await getIt<AppDb>().getEmployee(widget.id);
    userNameController.text = _employeeData.userName;
    firstNameController.text = _employeeData.firstName;
    lastNameController.text = _employeeData.lastName;
    emailController.text = _employeeData.userEmail;
    passwordController.text = _employeeData.password;
  }
}
