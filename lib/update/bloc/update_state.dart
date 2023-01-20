part of 'update_cubit.dart';

@immutable
abstract class UpdateState {}

class UpdateInitialState extends UpdateState {}

class UpdateErrorState extends UpdateState {}

class UpdateLoadingState extends UpdateState {}

class UpdateSuccessState extends UpdateState {}
