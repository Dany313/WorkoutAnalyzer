import 'package:go_router/go_router.dart';
import '../../features/workout/domain/entities/workout_plan.dart';
import '../../features/workout/domain/entities/workout_session.dart';
import '../../features/workout/domain/entities/workout_item.dart';
import '../../features/workout/presentation/pages/workout_plans_page.dart';
import '../../features/workout/presentation/pages/workout_plan_detail_page.dart';
import '../../features/workout/presentation/pages/workout_session_page.dart';
import '../../features/workout/presentation/pages/workout_item_detail_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WorkoutPlansPage(),
    ),
    GoRoute(
      path: '/plan/:id',
      builder: (context, state) {
        final plan = state.extra as WorkoutPlan;
        return WorkoutPlanDetailPage(plan: plan);
      },
    ),
    GoRoute(
      path: '/session/:id',
      builder: (context, state) {
        final session = state.extra as WorkoutSession;
        return WorkoutSessionPage(session: session);
      },
    ),
    GoRoute(
      path: '/item',
      builder: (context, state) {
        final item = state.extra as WorkoutItem;
        return WorkoutItemDetailPage(item: item);
      },
    ),
  ],
);
