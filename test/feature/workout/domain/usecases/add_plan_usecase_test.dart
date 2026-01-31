import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workout_app/core/error/failure.dart';
import 'package:workout_app/features/plan/domain/repository/plan_repository.dart';
import 'package:workout_app/features/plan/domain/usecases/add_plan_usecase.dart';


class MockWorkoutRepository extends Mock implements PlanRepository {}

void main() {
  late AddPlanUseCase usecase;
  late MockWorkoutRepository mockRepository;

  setUp(() {
    mockRepository = MockWorkoutRepository();
    usecase = AddPlanUseCase(mockRepository);
  });


  String nameParam = 'prova123';
  String nameParamTooShort = 'prova';

  test('dovrebbe aggiungere un piano al repository', () async {
    // Arange
    when(
      () => mockRepository.addPlan(any(),),
    ).thenAnswer((_) async => Right(null));

    //Act
    final result = await usecase(nameParam);

    //Assert
    expect(result.isLeft(), equals(false));
    expect(result, equals(Right(null)));
    verify(
      () => mockRepository.addPlan(nameParam),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('dovrebbe dare errore quando API non disponibile', () async {
    // Arange
    when(
      () => mockRepository.addPlan(any()),
    ).thenAnswer((_) async => Left(ServerFailure("Servizio non disponibile")));

    //Act
    final result = await usecase(nameParam);

    //Assert
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()),
      (_) => fail('Expected Left but got Right'),
    );
    verify(
      () => mockRepository.addPlan(nameParam),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('dovrebbe restituire un errore di validazione se il nome è troppo corto', () async {
    // Act
    final result = await usecase(nameParamTooShort);

    // Assert
    expect(result.isLeft(), isTrue);
    result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (_) => fail('Previsto Left ma ottenuto Right'),
    );
    verifyZeroInteractions(mockRepository);
  });

  test('dovrebbe restituire un errore di validazione se il nome è vuoto', () async {
    // Act
    final result = await usecase('');

    // Assert
    expect(result.isLeft(), isTrue);
    result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (_) => fail('Previsto Left ma ottenuto Right'),
    );
    verifyZeroInteractions(mockRepository);
  });

  test('dovrebbe restituire un errore di validazione se il nome è troppo lungo', () async {
    //Arange
    String nameParamTooLong = '';
    for(int i = 0; i < 10; i++){
      nameParamTooLong += nameParamTooShort;
    }
    // Act
    final result = await usecase(nameParamTooLong);

    // Assert
    expect(result.isLeft(), isTrue);
    result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (_) => fail('Previsto Left ma ottenuto Right'),
    );
    verifyZeroInteractions(mockRepository);
  });
}
