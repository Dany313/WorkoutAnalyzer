// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:workout_app/core/error/failure.dart';
// import 'package:workout_app/features/plan/domain/repository/plan_repository.dart';
// import 'package:workout_app/features/plan/domain/usecases/add_plan_usecase.dart';
//
//
// class MockWorkoutRepository extends Mock implements PlanRepository {}
//
// void main() {
//   late AddPlan usecase;
//   late MockWorkoutRepository mockRepository;
//
//   setUp(() {
//     mockRepository = MockWorkoutRepository();
//     usecase = AddPlan(mockRepository);
//   });
//
//   const params = AddWorkoutPlanParams.empty();
//
//   test('dovrebbe aggiungere un piano al repository', () async {
//     // Arange
//     when(
//       () => mockRepository.addPlan(
//         name: any(named: 'name'),
//         validFrom: any(named: 'validFrom'),
//         validTo: any(named: 'validTo'),
//         description: any(named: 'description'),
//       ),
//     ).thenAnswer((_) async => Right(null));
//
//     //Act
//     final result = await usecase(params);
//
//     //Assert
//     expect(result.isLeft(), equals(false));
//     expect(result, equals(Right(null)));
//     verify(
//       () => mockRepository.addPlan(
//         name: params.name,
//         validFrom: params.validFrom,
//         validTo: params.validTo,
//         description: params.description,
//       ),
//     ).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });
//
//   test('dovrebbe dare errore quando API non disponibile', () async {
//     // Arange
//     when(
//       () => mockRepository.addPlan(
//         name: any(named: 'name'),
//         validFrom: any(named: 'validFrom'),
//         validTo: any(named: 'validTo'),
//         description: any(named: 'description'),
//       ),
//     ).thenAnswer((_) async => Left(ServerFailure("Servizio non disponibile")));
//
//     //Act
//     final result = await usecase(params);
//
//     //Assert
//     expect(result.isLeft(), true);
//     result.fold(
//       (failure) => expect(failure, isA<ServerFailure>()),
//       (_) => fail('Expected Left but got Right'),
//     );
//     verify(
//       () => mockRepository.addPlan(
//         name: params.name,
//         validFrom: params.validFrom,
//         validTo: params.validTo,
//         description: params.description,
//       ),
//     ).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });
// }
