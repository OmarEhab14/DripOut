part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final String message;
  UserSuccess({required this.message});
}

final class UserFailure extends UserState {
  final String message;
  UserFailure({required this.message});
}