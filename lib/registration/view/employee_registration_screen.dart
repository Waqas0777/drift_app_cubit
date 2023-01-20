import 'package:drift_app_cubit/registration/bloc/registration_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeRegistrationScreen extends StatefulWidget {
  const EmployeeRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeRegistrationScreen> createState() =>
      _EmployeeRegistrationScreenState();
}

class _EmployeeRegistrationScreenState
    extends State<EmployeeRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _appDb.close();
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Employee Registration"),
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
              BlocConsumer<RegistrationCubit, RegistrationState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return CupertinoButton(
                    color: Colors.blue,
                    onPressed: () {
                      //addEmployee();

                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<RegistrationCubit>(context)
                            .submittedData(
                                context,
                                userNameController.text.trim(),
                                firstNameController.text.trim(),
                                lastNameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim());
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return UpdateEmployeeScreen();
                      // }));
                    },
                    child: const Text("Add"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
                }else if(value.length<6){
                  return "Username should be greater than 5 Character";
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
                }else if(value.length<6){
                  return "First name should be greater than 5 Character";
                }else {
                return null;}
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
                }else if(value.length<6){
                  return "Last Name should be greater than 5 Character";
                }else {
                return null;}
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
                }else if(!EmailValidator.validate(value)){
                  return "Please Enter Valid Email";
                }else{
                return null;}
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
                }else if(value.length <6){
                  return 'Password must be grater than 6 character';
                }else{
                return null;
              }},
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
}

// void showInSnackBar(context, String s) {
//   var snackBar = SnackBar(content: Text(s), backgroundColor: Colors.red);
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

// registrationButtonBlocWidget(context),
//
// BlocConsumer<RegistrationCubit, RegistrationState> registrationButtonBlocWidget(context) {
//   return BlocConsumer<RegistrationCubit, RegistrationState>(
//     listener: (context, state) {
//       if (state is RegistrationErrorState) {
//         showInSnackBar(context, "Failed");
//       } else if (state is RegistrationSuccessState) {
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => const RegisteredEmployeesScreen()));
//       } else {}
//     },
//     builder: (context, state) {
//       if (state is RegistrationInitialState) {
//         return signUpButtonWidget(context);
//       } else if (state is RegistrationLoadingState) {
//         return const CircularProgressIndicator();
//       } else {
//         return signUpButtonWidget(context);
//       }
//       // return CupertinoButton(
//       //     color: Colors.blue,
//       //     child: const Text("Signup"),
//       //     onPressed: () {
//       //       if (_formKey.currentState!.validate()) {
//       //         BlocProvider.of<SignupCubit>(context).submittedData(
//       //             context,
//       //             usernameController.text,
//       //             emailController.text,
//       //             passwordController.text);
//       //       }
//       //     });
//     },
//   );
// }
//
// Widget signUpButtonWidget(BuildContext context) {
//   return CupertinoButton(
//       color: Colors.blue,
//       child: const Text("Login"),
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           BlocProvider.of<RegistrationCubit>(context).submittedData(
//               context,
//               userNameController.text,
//               firstNameController.text,
//               lastNameController.text,
//               emailController.text,
//               passwordController.text);
//         }
//       });
// }
