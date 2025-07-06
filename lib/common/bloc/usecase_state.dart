part of 'usecase_cubit.dart';

@immutable
sealed class UseCaseState {}

final class UseCaseInitial extends UseCaseState {}

final class UseCaseLoading extends UseCaseState {}

final class UseCaseSuccess extends UseCaseState {}

final class UseCaseFailure extends UseCaseState {
  final String errorMessage;
  UseCaseFailure({required this.errorMessage});
}
