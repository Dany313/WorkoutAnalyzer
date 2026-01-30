import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_state.dart';
import 'package:workout_app/features/workout/presentation/forms/workout_form.dart';
import '../../domain/usecases/add_workout_usecase.dart';
import '../../domain/usecases/delete_workout_usecase.dart';
import '../../domain/usecases/get_workouts_usecase.dart';
import '../../domain/usecases/update_workout_usecase.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutsUseCase getWorkoutsUseCase;
  final AddWorkoutUseCase addWorkoutUseCase;
  final DeleteWorkoutUseCase deleteWorkoutUseCase;
  final UpdateWorkoutUseCase updateWorkoutUseCase;

  WorkoutBloc({required this.getWorkoutsUseCase,
    required this.addWorkoutUseCase,
    required this.deleteWorkoutUseCase,
    required this.updateWorkoutUseCase
  }) : super(const WorkoutState()) {
    on<GetWorkoutsEvent>(_onGetWorkouts);
    on<WorkoutNameChanged>(_onWorkoutNameChanged);
    on<AddWorkoutEvent>(_onAddWorkout);
    on<RemoveWorkoutEvent>(_onRemoveWorkout);
    on<UpdateWorkoutEvent>(_updateWorkout);
  }

  void _onWorkoutNameChanged(WorkoutNameChanged event, Emitter<WorkoutState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      workoutName: name,
      isValid: Formz.validate([name]),
    ));
  }

  Future<void> _updateWorkout(UpdateWorkoutEvent event, Emitter<WorkoutState> emit) async {
    emit(state.copyWith(status: WorkoutStatus.updating));

    final result = await updateWorkoutUseCase(UpdateWorkoutParams(id: event.id, name: state.workoutName.value));

    result.fold(
          (error) => emit(state.copyWith(status: WorkoutStatus.failure, errorMessage: error.message)),
          (r) => emit(state.copyWith(status: WorkoutStatus.reloading,isValid: false, workoutName: const Name.pure())),
    );


  }


  Future<void> _onGetWorkouts(GetWorkoutsEvent event, Emitter<WorkoutState> emit,
      ) async {
    emit(state.copyWith(status: WorkoutStatus.loading));

    final result = await getWorkoutsUseCase(event.planId);

    result.fold(
          (error) => emit(state.copyWith(status: WorkoutStatus.failure, errorMessage: error.message)),
          (workouts) => emit(state.copyWith(status: WorkoutStatus.success, workouts: workouts)),
    );
  }

  Future<void> _onAddWorkout(AddWorkoutEvent event, Emitter<WorkoutState> emit,
      ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: WorkoutStatus.creating));

    final result = await addWorkoutUseCase(AddWorkoutParams(name: state.workoutName.value, planId: event.planId));

    result.fold(
          (error) => emit(state.copyWith(status: WorkoutStatus.failure, errorMessage: error.message)),
          (r) => emit(state.copyWith(status: WorkoutStatus.reloading, isValid: false, workoutName: const Name.pure())),
    );

  }

  Future<void> _onRemoveWorkout(RemoveWorkoutEvent event, Emitter<WorkoutState> emit,
      ) async {
    emit(state.copyWith(status: WorkoutStatus.removing));

    final result = await deleteWorkoutUseCase(event.id);

    result.fold(
          (error) => emit(state.copyWith(status: WorkoutStatus.failure, errorMessage: error.message)),
          (r) => emit(state.copyWith(status: WorkoutStatus.reloading)),
    );

  }
}
