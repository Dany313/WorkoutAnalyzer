import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/features/plan/presentation/bloc/plan_event.dart';
import 'package:workout_app/features/plan/presentation/bloc/plan_state.dart';
import '../../domain/usecases/add_plan_usecase.dart';
import '../../domain/usecases/delete_plan_usecase.dart';
import '../../domain/usecases/get_plans_usecase.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final GetPlansUseCase getPlansUseCase;
  final AddPlanUseCase addPlanUseCase;
  final DeletePlanUseCase deletePlanUseCase;

  PlanBloc({required this.getPlansUseCase,
    required this.addPlanUseCase,
    required this.deletePlanUseCase
  })
    : super(const PlanInitialState()) {
    on<GetPlansEvent>(_onGetPlans);
    on<AddPlanEvent>(_onAddPlan);
    on<RemovePlanEvent>(_onRemovePlan);
    add(GetPlansEvent());
  }
  Future<void> _onGetPlans(GetPlansEvent event, Emitter<PlanState> emit,
  ) async {
    emit(const PlanLoadingState());

    final result = await getPlansUseCase();

    result.fold(
      (error) => emit(PlanErrorState(error.message)),
      (plans) => emit(PlanLoadedState(plans)),
    );
  }

  Future<void> _onAddPlan(AddPlanEvent event, Emitter<PlanState> emit,
      ) async {
    emit(const CreatingPlanState());

    final result = await addPlanUseCase(event.name);

    result.fold(
          (error) => emit(PlanErrorState(error.message)),
          (plans) => emit(PlanCreatedState()),
    );

    add(GetPlansEvent());
  }

  Future<void> _onRemovePlan(RemovePlanEvent event, Emitter<PlanState> emit,
      ) async {
    emit(const RemovingPlanState());

    final result = await deletePlanUseCase(event.id);

    result.fold(
          (error) => emit(PlanErrorState(error.message)),
          (plans) => emit(PlanRemovedState()),
    );

    add(GetPlansEvent());
  }
}
