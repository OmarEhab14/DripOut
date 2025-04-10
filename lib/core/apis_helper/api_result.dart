import 'package:drip_out/core/apis_helper/api_error_model.dart';

abstract class ApiResult<T> {
  const ApiResult();
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final ApiErrorModel apiErrorModel;
  const Failure(this.apiErrorModel);
}