import 'package:formz/formz.dart';
import '../../domain/entity/exercise_entity.dart';

enum NameValidationError { empty, tooShort, tooLong }

enum DescriptionValidationError { none }

enum TargetMusclesValidationError { none }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    return value.length < 6 ? NameValidationError.tooShort : null;
  }
}

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([super.value = '']) : super.dirty();

  @override
  DescriptionValidationError? validator(String value) {
    // La description è opzionale, quindi non ha errori di validazione
    return null;
  }
}

class TargetMuscles
    extends FormzInput<Map<MuscleGroups, int>, TargetMusclesValidationError> {
  const TargetMuscles.pure() : super.pure(const {});
  const TargetMuscles.dirty([super.value = const {}]) : super.dirty();

  @override
  TargetMusclesValidationError? validator(Map<MuscleGroups, int> value) {
    // I muscoli target sono opzionali
    return null;
  }
}
