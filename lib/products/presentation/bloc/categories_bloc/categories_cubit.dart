import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/products/data/models/categories_response_model.dart';
import 'package:drip_out/products/domain/usecases/get_categories_usecase.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoriesCubit(this.getCategoriesUseCase) : super(CategoriesInitial());
  
  Future<void> loadCategories() async {
    emit(CategoriesLoading());
    final result = await getCategoriesUseCase();
    if (result is Success<CategoriesResponseModel>) {
      emit(CategoriesSuccess(result.data));
    } else if (result is Failure<CategoriesResponseModel>) {
      log(result.apiErrorModel.message);
      emit(CategoriesFailed(result.apiErrorModel));
    }
  }
}
