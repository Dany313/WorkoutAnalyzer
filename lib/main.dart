import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/features/plan/domain/usecases/update_plan_usecase.dart';
import 'package:workout_app/injection.dart';
import 'core/router.dart';
import 'package:workout_app/features/plan/domain/usecases/get_plans_usecase.dart';
import 'package:workout_app/features/plan/domain/usecases/add_plan_usecase.dart';
import 'package:workout_app/features/plan/presentation/bloc/plan_bloc.dart';

import 'features/exercises/domain/usecases/add_exercise_usecase.dart';
import 'features/exercises/domain/usecases/delete_exercise_usecase.dart';
import 'features/exercises/domain/usecases/get_exercises_usecase.dart';
import 'features/exercises/domain/usecases/update_exercise_usecase.dart';
import 'features/exercises/presentation/bloc/exercise_bloc.dart';
import 'features/plan/domain/usecases/delete_plan_usecase.dart';
import 'package:workout_app/features/workout/domain/usecases/get_workouts_usecase.dart';
import 'package:workout_app/features/workout/domain/usecases/add_workout_usecase.dart';
import 'package:workout_app/features/workout/domain/usecases/delete_workout_usecase.dart';
import 'package:workout_app/features/workout/domain/usecases/update_workout_usecase.dart';
import 'package:workout_app/features/workout/presentation/bloc/workout_bloc.dart';

void main() {
  // Assicurati che i widget siano pronti prima di configurare la DI
  WidgetsFlutterBinding.ensureInitialized();

  // Configura le dipendenze
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlanBloc(
            getPlansUseCase: getIt<GetPlansUseCase>(),
            addPlanUseCase: getIt<AddPlanUseCase>(),
            deletePlanUseCase: getIt<DeletePlanUseCase>(),
            updatePlanUseCase: getIt<UpdatePlanUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => WorkoutBloc(
            getWorkoutsUseCase: getIt<GetWorkoutsUseCase>(),
            addWorkoutUseCase: getIt<AddWorkoutUseCase>(),
            deleteWorkoutUseCase: getIt<DeleteWorkoutUseCase>(),
            updateWorkoutUseCase: getIt<UpdateWorkoutUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => ExerciseBloc(
            getExercisesUseCase: getIt<GetExercisesUseCase>(),
            addExerciseUseCase: getIt<AddExerciseUseCase>(),
            deleteExerciseUseCase: getIt<DeleteExerciseUseCase>(),
            updateExerciseUseCase: getIt<UpdateExerciseUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Workout App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
