import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/injection.dart';
import 'package:workout_app/features/plan/domain/usecases/get_plans_usecase.dart';
import 'package:workout_app/features/plan/domain/usecases/add_plan_usecase.dart';
import 'package:workout_app/features/plan/presentation/bloc/plan_bloc.dart';

import 'features/plan/domain/usecases/delete_plan_usecase.dart';
import 'features/plan/presentation/pages/plans_page.dart';

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
    return BlocProvider(
      create:
          (context) => PlanBloc(
            getPlansUseCase: getIt<GetPlansUseCase>(),
            addPlanUseCase: getIt<AddPlanUseCase>(),
            deletePlanUseCase: getIt<DeletePlanUseCase>(),
          ),
      child: MaterialApp(
        title: 'Workout App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const PlansPage(),
      ),
    );
  }
}
