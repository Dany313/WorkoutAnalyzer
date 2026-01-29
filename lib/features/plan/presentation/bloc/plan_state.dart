import 'package:formz/formz.dart';

import '../../domain/entity/plan_entity.dart';
import '../forms/plan_form.dart';
// Importa il tuo PlanName (Value Object Formz creato prima)

enum PlanStatus { initial, loading, success, failure, creating, removing }

class PlanState {
  final List<PlanEntity> plans;
  final PlanStatus status;
  final String? errorMessage;

  // Campi Formz
  final Name planName;
  final bool isValid;

  const PlanState({
    this.plans = const [],
    this.status = PlanStatus.initial,
    this.errorMessage,
    this.planName = const Name.pure(),
    this.isValid = false,
  });

  PlanState copyWith({
    List<PlanEntity>? plans,
    PlanStatus? status,
    String? errorMessage,
    Name? planName,
    bool? isValid,
  }) {
    return PlanState(
      plans: plans ?? this.plans,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      planName: planName ?? this.planName,
      isValid: isValid ?? this.isValid,
    );
  }
}