import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../repository/plan_repository.dart';

@lazySingleton
class AddPlanUseCase implements UseCaseWithParams<void, String> {
  final PlanRepository repository;

  AddPlanUseCase(this.repository);

  @override
  ResultFuture<void> call(String name) async {
    // Validazione prima di chiamare il repository
    if (name.isEmpty) {
      return Left(ServerFailure('Il nome non può essere vuoto'));
    }
    if (name.length < 6) {
      return Left(ServerFailure('Il nome deve avere almeno 6 caratteri'));
    }
    if (name.length > 32) {
      return Left(ServerFailure('Il nome non può avere più di 32 caratteri'));
    }

    return await repository.addPlan(name);
  }
}
