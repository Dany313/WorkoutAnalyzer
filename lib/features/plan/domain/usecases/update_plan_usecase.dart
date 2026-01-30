import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:workout_app/core/usecases/usecase.dart';
import 'package:workout_app/core/utils/typedef.dart';
import 'package:workout_app/core/error/failure.dart';

import '../repository/plan_repository.dart';

@lazySingleton
class UpdatePlanUseCase implements UseCaseWithParams<void, UpdatePlanParams> {
  final PlanRepository repository;

  UpdatePlanUseCase(this.repository);

  @override
  ResultFuture<void> call(UpdatePlanParams params) async {
    // Validazione prima di chiamare il repository
    if (params.name.isEmpty) {
      return Left(ServerFailure('Il nome non può essere vuoto'));
    }
    if (params.name.length < 6) {
      return Left(ServerFailure('Il nome deve avere almeno 6 caratteri'));
    }
    if (params.name.length > 32) {
      return Left(ServerFailure('Il nome non può avere più di 32 caratteri'));
    }

    return await repository.updatePlan(params);
  }
}

class UpdatePlanParams {
  final String id;
  final String name;


  const UpdatePlanParams({
    required this.id , required this.name});

  UpdatePlanParams copyWith({
    String? id,
    String? name,
  }) {
    return UpdatePlanParams(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
