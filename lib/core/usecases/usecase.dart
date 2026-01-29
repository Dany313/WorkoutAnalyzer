import 'package:workout_app/core/utils/typedef.dart';

abstract class UseCaseWithParams<T, Params> {
  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  ResultFuture<T> call();
}
