import 'package:bloc/bloc.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  final UseCase useCase;
  ButtonCubit(this.useCase) : super(ButtonInitial());

  void execute({dynamic params}) async {
    emit(ButtonLoading());
    // await Future.delayed(const Duration(seconds: 5));
    try {
      final ApiResult result = await useCase.call(params: params);
      if(result is Success) {
        emit(ButtonSuccess());
      } else if(result is Failure) {
        emit(ButtonFailure(errorMessage: result.apiErrorModel.message));
      } else {
        emit(ButtonFailure(errorMessage: 'Error: Not an api result instance'));
      }
    } catch (e) {
      emit(ButtonFailure(errorMessage: e.toString()));
    }

  }
}
