import 'package:bloc/bloc.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'usecase_state.dart';

class UseCaseCubit extends Cubit<UseCaseState> {
  final UseCase useCase;
  UseCaseCubit(this.useCase) : super(UseCaseInitial());

  void execute({dynamic params}) async {
    emit(UseCaseLoading());
    // await Future.delayed(const Duration(seconds: 5));
    try {
      final ApiResult result = await useCase.call(params: params);
      if(result is Success) {
        emit(UseCaseSuccess());
      } else if(result is Failure) {
        emit(UseCaseFailure(errorMessage: result.apiErrorModel.message));
      } else {
        emit(UseCaseFailure(errorMessage: 'Error: Not an api result instance'));
      }
    } catch (e) {
      emit(UseCaseFailure(errorMessage: e.toString()));
    }
  }
}
