part of 'registered_cubit.dart';

@immutable
abstract class RegisteredState {}

class RegisteredInitialState extends RegisteredState {

}

class RegisteredLoadingState extends RegisteredState {}

class RegisteredLoadedState extends RegisteredState {
  final Set<EmployeeData> empList;
  RegisteredLoadedState(this.empList);
}

class RegisteredErrorState extends RegisteredState {
  final String errorMsg;
  RegisteredErrorState(this.errorMsg);
}


