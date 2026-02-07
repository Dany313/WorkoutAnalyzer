import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:workout_app/features/exercises/domain/usecases/add_exercise_usecase.dart';
import 'package:workout_app/features/exercises/domain/usecases/get_exercises_usecase.dart';
import 'package:workout_app/features/exercises/presentation/forms/exercise_form.dart';
import 'package:workout_app/features/training/domain/usecase/add_train_ex_usecase.dart';
import 'package:workout_app/features/training/domain/usecase/delete_train_ex_usecase.dart';
import 'package:workout_app/features/training/domain/usecase/get_train_ex_list_usecase.dart';
import 'package:workout_app/features/training/domain/usecase/update_train_ex_usecase.dart';
import 'package:workout_app/features/training/presentation/bloc/training_event.dart';
import 'package:workout_app/features/training/presentation/bloc/training_state.dart';
import 'package:workout_app/features/training/presentation/forms/training_form.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final GetTrainExListUsecase getTrainExListUsecase;
  final AddTrainExUsecase addTrainExUsecase;
  final DeleteTrainExUsecase deleteTrainExUsecase;
  final UpdateTrainExUsecase updateTrainExUsecase;
  final GetExercisesUseCase getExercisesUseCase;
  final AddExerciseUseCase addExerciseUseCase;

  TrainingBloc({
    required this.getTrainExListUsecase,
    required this.addTrainExUsecase,
    required this.deleteTrainExUsecase,
    required this.updateTrainExUsecase,
    required this.getExercisesUseCase,
    required this.addExerciseUseCase,
  }) : super(const TrainingState()) {
    on<TrainingLoadRequested>(_onLoadRequested);
    on<TrainingUseExistingExerciseToggled>(_onUseExistingToggled);
    on<TrainingExerciseSelected>(_onExerciseSelected);
    on<TrainingSetsChanged>(_onSetsChanged);
    on<TrainingRepsChanged>(_onRepsChanged);
    on<TrainingRestChanged>(_onRestChanged);
    on<TrainingRpeChanged>(_onRpeChanged);
    on<TrainingExerciseNameChanged>(_onExerciseNameChanged);
    on<TrainingExerciseDescriptionChanged>(_onExerciseDescriptionChanged);
    on<TrainingExerciseTargetMuscleAdded>(_onTargetMuscleAdded);
    on<TrainingExerciseTargetMuscleRemoved>(_onTargetMuscleRemoved);
    on<TrainingExerciseTargetMusclePercentageChanged>(
      _onTargetMusclePercentageChanged,
    );
    on<TrainingExerciseAdded>(_onExerciseAdded);
    on<TrainingExerciseRemoved>(_onExerciseRemoved);
  }

  Future<void> _onLoadRequested(
    TrainingLoadRequested event,
    Emitter<TrainingState> emit,
  ) async {
    emit(state.copyWith(status: TrainingStatus.loading, workoutId: event.workoutId));

    final trainingResult = await getTrainExListUsecase(event.workoutId);
    final exercisesResult = await getExercisesUseCase();

    trainingResult.fold(
      (error) => emit(
        state.copyWith(status: TrainingStatus.failure, errorMessage: error.message),
      ),
      (trainingExercises) {
        exercisesResult.fold(
          (error) => emit(
            state.copyWith(status: TrainingStatus.failure, errorMessage: error.message),
          ),
          (exercises) => emit(
            state.copyWith(
              status: TrainingStatus.success,
              trainingExercises: trainingExercises,
              exercises: exercises,
            ),
          ),
        );
      },
    );
  }

  void _onUseExistingToggled(
    TrainingUseExistingExerciseToggled event,
    Emitter<TrainingState> emit,
  ) {
    final updatedState = state.copyWith(
      useExistingExercise: event.useExisting,
      selectedExerciseId: event.useExisting ? state.selectedExerciseId : null,
      exerciseName: const Name.pure(),
      exerciseDescription: const Description.pure(),
      targetMuscles: const TargetMuscles.pure(),
    );
    emit(_validate(updatedState));
  }

  void _onExerciseSelected(
    TrainingExerciseSelected event,
    Emitter<TrainingState> emit,
  ) {
    emit(_validate(state.copyWith(selectedExerciseId: event.exerciseId)));
  }

  void _onSetsChanged(
    TrainingSetsChanged event,
    Emitter<TrainingState> emit,
  ) {
    final sets = SetsInput.dirty(event.sets);
    emit(_validate(state.copyWith(sets: sets)));
  }

  void _onRepsChanged(
    TrainingRepsChanged event,
    Emitter<TrainingState> emit,
  ) {
    final reps = RepsInput.dirty(event.reps);
    emit(_validate(state.copyWith(reps: reps)));
  }

  void _onRestChanged(
    TrainingRestChanged event,
    Emitter<TrainingState> emit,
  ) {
    final rest = RestSecondsInput.dirty(event.restSeconds);
    emit(_validate(state.copyWith(restSeconds: rest)));
  }

  void _onRpeChanged(
    TrainingRpeChanged event,
    Emitter<TrainingState> emit,
  ) {
    final rpe = RpeInput.dirty(event.rpe);
    emit(_validate(state.copyWith(rpe: rpe)));
  }

  void _onExerciseNameChanged(
    TrainingExerciseNameChanged event,
    Emitter<TrainingState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(_validate(state.copyWith(exerciseName: name)));
  }

  void _onExerciseDescriptionChanged(
    TrainingExerciseDescriptionChanged event,
    Emitter<TrainingState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(_validate(state.copyWith(exerciseDescription: description)));
  }

  void _onTargetMuscleAdded(
    TrainingExerciseTargetMuscleAdded event,
    Emitter<TrainingState> emit,
  ) {
    final newMuscles = Map<MuscleGroups, int>.from(state.targetMuscles.value);
    newMuscles[event.muscle] = event.percentage;
    final targetMuscles = TargetMuscles.dirty(newMuscles);
    emit(_validate(state.copyWith(targetMuscles: targetMuscles)));
  }

  void _onTargetMuscleRemoved(
    TrainingExerciseTargetMuscleRemoved event,
    Emitter<TrainingState> emit,
  ) {
    final newMuscles = Map<MuscleGroups, int>.from(state.targetMuscles.value);
    newMuscles.remove(event.muscle);
    final targetMuscles = TargetMuscles.dirty(newMuscles);
    emit(_validate(state.copyWith(targetMuscles: targetMuscles)));
  }

  void _onTargetMusclePercentageChanged(
    TrainingExerciseTargetMusclePercentageChanged event,
    Emitter<TrainingState> emit,
  ) {
    final newMuscles = Map<MuscleGroups, int>.from(state.targetMuscles.value);
    newMuscles[event.muscle] = event.percentage;
    final targetMuscles = TargetMuscles.dirty(newMuscles);
    emit(_validate(state.copyWith(targetMuscles: targetMuscles)));
  }

  Future<void> _onExerciseAdded(
    TrainingExerciseAdded event,
    Emitter<TrainingState> emit,
  ) async {
    if (!state.isValid || state.workoutId == null) return;

    emit(state.copyWith(status: TrainingStatus.creating));

    String exerciseId = state.selectedExerciseId ?? '';

    if (!state.useExistingExercise) {
      final exerciseResult = await addExerciseUseCase(
        AddExerciseParams(
          name: state.exerciseName.value,
          description: state.exerciseDescription.value,
          targetMuscles: state.targetMuscles.value,
        ),
      );

      final maybeExerciseId = exerciseResult.fold<String?>(
        (error) {
          emit(state.copyWith(status: TrainingStatus.failure, errorMessage: error.message));
          return null;
        },
        (id) => id,
      );

      if (maybeExerciseId == null) {
        return;
      }

      exerciseId = maybeExerciseId;
    }

    final addResult = await addTrainExUsecase(
      AddTrainExParams(
        workoutId: state.workoutId!,
        exerciseId: exerciseId,
        sets: int.parse(state.sets.value),
        reps: int.parse(state.reps.value),
        restSeconds: state.restSeconds.value.isEmpty
            ? 0
            : int.parse(state.restSeconds.value),
        rpe: int.parse(state.rpe.value),
      ),
    );

    addResult.fold(
      (error) => emit(
        state.copyWith(status: TrainingStatus.failure, errorMessage: error.message),
      ),
      (r) => emit(
        state.copyWith(
          status: TrainingStatus.reloading,
          isValid: false,
          sets: const SetsInput.pure(),
          reps: const RepsInput.pure(),
          restSeconds: const RestSecondsInput.pure(),
          rpe: const RpeInput.pure(),
          exerciseName: const Name.pure(),
          exerciseDescription: const Description.pure(),
          targetMuscles: const TargetMuscles.pure(),
          selectedExerciseId: null,
          useExistingExercise: true,
        ),
      ),
    );
  }

  Future<void> _onExerciseRemoved(
    TrainingExerciseRemoved event,
    Emitter<TrainingState> emit,
  ) async {
    emit(state.copyWith(status: TrainingStatus.removing));

    final result = await deleteTrainExUsecase(event.id);

    result.fold(
      (error) => emit(
        state.copyWith(status: TrainingStatus.failure, errorMessage: error.message),
      ),
      (r) => emit(state.copyWith(status: TrainingStatus.reloading)),
    );
  }

  TrainingState _validate(TrainingState currentState) {
    final inputs = [
      currentState.sets,
      currentState.reps,
      currentState.restSeconds,
      currentState.rpe,
    ];
    final areNumbersValid = Formz.validate(inputs);
    final hasExercise = currentState.useExistingExercise
        ? currentState.selectedExerciseId != null
        : currentState.exerciseName.valid;

    return currentState.copyWith(isValid: areNumbersValid && hasExercise);
  }
}
