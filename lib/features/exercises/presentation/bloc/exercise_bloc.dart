import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../domain/entity/exercise_entity.dart';
import '../../domain/usecases/add_exercise_usecase.dart';
import '../../domain/usecases/delete_exercise_usecase.dart';
import '../../domain/usecases/get_exercises_usecase.dart';
import '../../domain/usecases/update_exercise_usecase.dart';
import '../forms/exercise_form.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final GetExercisesUseCase getExercisesUseCase;
  final AddExerciseUseCase addExerciseUseCase;
  final DeleteExerciseUseCase deleteExerciseUseCase;
  final UpdateExerciseUseCase updateExerciseUseCase;

  ExerciseBloc({
    required this.getExercisesUseCase,
    required this.addExerciseUseCase,
    required this.deleteExerciseUseCase,
    required this.updateExerciseUseCase,
  }) : super(const ExerciseState()) {
    on<GetExercisesEvent>(_onGetExercises);
    on<ExerciseNameChanged>(_onExerciseNameChanged);
    on<ExerciseDescriptionChanged>(_onExerciseDescriptionChanged);
    on<ExerciseTargetMuscleAdded>(_onExerciseTargetMuscleAdded);
    on<ExerciseTargetMuscleRemoved>(_onExerciseTargetMuscleRemoved);
    on<ExerciseTargetMusclePercentageChanged>(
      _onExerciseTargetMusclePercentageChanged,
    );
    on<AddExerciseEvent>(_onAddExercise);
    on<RemoveExerciseEvent>(_onRemoveExercise);
    on<UpdateExerciseEvent>(_updateExercise);

    add(GetExercisesEvent());
  }

  void _onExerciseNameChanged(
    ExerciseNameChanged event,
    Emitter<ExerciseState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(exerciseName: name, isValid: Formz.validate([name])));
  }

  void _onExerciseDescriptionChanged(
    ExerciseDescriptionChanged event,
    Emitter<ExerciseState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(state.copyWith(description: description));
  }

  void _onExerciseTargetMuscleAdded(
    ExerciseTargetMuscleAdded event,
    Emitter<ExerciseState> emit,
  ) {
    final newMuscles = Map<MuscleGroups, int>.from(state.targetMuscles.value);
    newMuscles[event.muscle] = event.percentage;
    final targetMuscles = TargetMuscles.dirty(newMuscles);
    emit(state.copyWith(targetMuscles: targetMuscles));
  }

  void _onExerciseTargetMuscleRemoved(
    ExerciseTargetMuscleRemoved event,
    Emitter<ExerciseState> emit,
  ) {
    final newMuscles = Map<MuscleGroups, int>.from(state.targetMuscles.value);
    newMuscles.remove(event.muscle);
    final targetMuscles = TargetMuscles.dirty(newMuscles);
    emit(state.copyWith(targetMuscles: targetMuscles));
  }

  void _onExerciseTargetMusclePercentageChanged(
    ExerciseTargetMusclePercentageChanged event,
    Emitter<ExerciseState> emit,
  ) {
    final newMuscles = Map<MuscleGroups, int>.from(state.targetMuscles.value);
    newMuscles[event.muscle] = event.percentage;
    final targetMuscles = TargetMuscles.dirty(newMuscles);
    emit(state.copyWith(targetMuscles: targetMuscles));
  }

  Future<void> _updateExercise(
    UpdateExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(state.copyWith(status: ExerciseStatus.updating));

    final result = await updateExerciseUseCase(
      UpdateExerciseParams(
        id: event.id,
        name: state.exerciseName.value,
        description: state.description.value,
        targetMuscles: state.targetMuscles.value,
      ),
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          status: ExerciseStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ExerciseStatus.reloading,
          isValid: false,
          exerciseName: const Name.pure(),
          description: const Description.pure(),
          targetMuscles: const TargetMuscles.pure(),
        ),
      ),
    );
  }

  Future<void> _onGetExercises(
    GetExercisesEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(state.copyWith(status: ExerciseStatus.loading));

    final result = await getExercisesUseCase();

    result.fold(
      (error) => emit(
        state.copyWith(
          status: ExerciseStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (workouts) => emit(
        state.copyWith(status: ExerciseStatus.success, workouts: workouts),
      ),
    );
  }

  Future<void> _onAddExercise(
    AddExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: ExerciseStatus.creating));

    final result = await addExerciseUseCase(
      AddExerciseParams(
        name: state.exerciseName.value,
        description: state.description.value,
        targetMuscles: state.targetMuscles.value,
      ),
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          status: ExerciseStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ExerciseStatus.reloading,
          isValid: false,
          exerciseName: const Name.pure(),
          description: const Description.pure(),
          targetMuscles: const TargetMuscles.pure(),
        ),
      ),
    );
  }

  Future<void> _onRemoveExercise(
    RemoveExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(state.copyWith(status: ExerciseStatus.removing));

    final result = await deleteExerciseUseCase(event.id);

    result.fold(
      (error) => emit(
        state.copyWith(
          status: ExerciseStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (r) => emit(state.copyWith(status: ExerciseStatus.reloading)),
    );
  }
}
