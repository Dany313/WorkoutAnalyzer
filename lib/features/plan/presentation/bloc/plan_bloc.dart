import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:workout_app/features/plan/domain/usecases/update_plan_usecase.dart';
import 'package:workout_app/features/plan/presentation/bloc/plan_event.dart';
import 'package:workout_app/features/plan/presentation/bloc/plan_state.dart';
import 'package:workout_app/features/plan/presentation/forms/plan_form.dart';
import '../../domain/usecases/add_plan_usecase.dart';
import '../../domain/usecases/delete_plan_usecase.dart';
import '../../domain/usecases/get_plans_usecase.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final GetPlansUseCase getPlansUseCase;
  final AddPlanUseCase addPlanUseCase;
  final DeletePlanUseCase deletePlanUseCase;
  final UpdatePlanUseCase updatePlanUseCase;

  PlanBloc({required this.getPlansUseCase,
    required this.addPlanUseCase,
    required this.deletePlanUseCase,
    required this.updatePlanUseCase
  })
    : super(const PlanState()) {
    on<GetPlansEvent>(_onGetPlans);
    on<PlanNameChanged>(_onPlanNameChanged);
    on<AddPlanEvent>(_onAddPlan);
    on<RemovePlanEvent>(_onRemovePlan);
    on<UpdatePlanEvent>(_updatePlan);
    add(GetPlansEvent());
  }

  // Gestisce la digitazione nel form
  void _onPlanNameChanged(PlanNameChanged event, Emitter<PlanState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      planName: name,
      isValid: Formz.validate([name]), // Abilita/Disabilita il bottone
    ));
  }

  Future<void>_updatePlan(UpdatePlanEvent event, Emitter<PlanState> emit,
      ) async {
    emit(state.copyWith(status: PlanStatus.updating));

    final result = await updatePlanUseCase(UpdatePlanParams(id: event.id, name: state.planName.value));

    result.fold(
          (error) => emit(state.copyWith(status: PlanStatus.failure, errorMessage: error.message)),
          (plans) => emit(state.copyWith(status: PlanStatus.success,isValid: false, planName: const Name.pure())),
    );

    add(GetPlansEvent());

  }


  Future<void> _onGetPlans(GetPlansEvent event, Emitter<PlanState> emit,
  ) async {
    emit(state.copyWith(status: PlanStatus.loading));

    final result = await getPlansUseCase();

    result.fold(
      (error) => emit(state.copyWith(status: PlanStatus.failure, errorMessage: error.message)),
      (plans) => emit(state.copyWith(status: PlanStatus.success, plans: plans)),
    );
  }

  Future<void> _onAddPlan(AddPlanEvent event, Emitter<PlanState> emit,
      ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: PlanStatus.creating));

    final result = await addPlanUseCase(state.planName.value);

    result.fold(
          (error) => emit(state.copyWith(status: PlanStatus.failure, errorMessage: error.message)),
          (plans) => emit(state.copyWith(status: PlanStatus.success, isValid: false, planName: const Name.pure())),
    );

    add(GetPlansEvent());
  }

  Future<void> _onRemovePlan(RemovePlanEvent event, Emitter<PlanState> emit,
      ) async {
    emit(state.copyWith(status: PlanStatus.removing));

    final result = await deletePlanUseCase(event.id);

    result.fold(
          (error) => emit(state.copyWith(status: PlanStatus.failure, errorMessage: error.message)),
          (plans) => emit(state.copyWith(status: PlanStatus.success)),
    );

    add(GetPlansEvent());
  }
}
