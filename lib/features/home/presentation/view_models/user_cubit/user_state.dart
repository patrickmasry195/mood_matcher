part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String name;
  final String avatarUrl;

  UserLoaded({required this.name, required this.avatarUrl});
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});
}
