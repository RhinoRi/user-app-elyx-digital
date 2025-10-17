import 'package:elyx_digital_user_app/features/users/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> data;
  final bool hasReachedEnd;

  UserLoaded({required this.data, required this.hasReachedEnd});
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});
}
