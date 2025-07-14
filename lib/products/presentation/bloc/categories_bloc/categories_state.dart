part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final CategoriesResponseModel categoriesResponse;
  CategoriesSuccess(this.categoriesResponse);
}

final class CategoriesFailed extends CategoriesState {
  final ApiErrorModel error;
  CategoriesFailed(this.error);
}

