import 'package:dartz/dartz.dart';
import 'package:workout_app/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;
