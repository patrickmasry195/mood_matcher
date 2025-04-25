part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String name;
  final String avatarUrl;
  final String email;

  UserLoaded({
    required this.name,
    required this.avatarUrl,
    required this.email,
  });
}

class UserDeleted extends UserState {}

class UserSignedOut extends UserState {}

class UserError extends UserState {
  final String message;

  UserError({required this.message});
}
