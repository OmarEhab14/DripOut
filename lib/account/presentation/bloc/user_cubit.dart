import 'package:bloc/bloc.dart';
import 'package:drip_out/account/domain/usecases/get_user_usecase.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UseCase useCase;
  UserCubit(this.useCase) : super(UserInitial());

  void execute() async {
    emit(UserLoading());
    // await Future.delayed(const Duration(seconds: 5));
    try {
      final ApiResult result = await useCase.call();
      if (result is Success) {
        emit(UserSuccess(message: result.data));
      } else if (result is Failure) {
        emit(UserFailure(message: result.apiErrorModel.message));
      } else {
        emit(UserFailure(message: 'Error: Not an api result instance'));
      }
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }
}
