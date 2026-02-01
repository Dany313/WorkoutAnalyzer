import 'package:go_router/go_router.dart';
import 'package:workout_app/features/exercises/presentation/pages/exercises_page.dart';
import 'package:workout_app/features/plan/presentation/pages/plans_page.dart';
import 'package:workout_app/features/workout/presentation/pages/workouts_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'plans',
      builder: (context, state) => const PlansPage(),
    ),
    GoRoute(
      path: '/plans/:planId/workouts',
      name: 'workouts',
      builder: (context, state) {
        final planId = state.pathParameters['planId']!;
        return WorkoutsPage(planId: planId);
      },
    ),
    GoRoute(
      path: '/exercises',
      name: 'exercises',
      builder: (context, state) => const ExercisesPage(),
    ),
  ],
);
