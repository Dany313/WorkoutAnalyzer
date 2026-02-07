import 'package:formz/formz.dart';

enum SetsValidationError { empty, invalid }
enum RepsValidationError { empty, invalid }
enum RestSecondsValidationError { invalid }
enum RpeValidationError { empty, invalid }

class SetsInput extends FormzInput<String, SetsValidationError> {
  const SetsInput.pure() : super.pure('');
  const SetsInput.dirty([super.value = '']) : super.dirty();

  @override
  SetsValidationError? validator(String value) {
    if (value.isEmpty) return SetsValidationError.empty;
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) return SetsValidationError.invalid;
    return null;
  }
}

class RepsInput extends FormzInput<String, RepsValidationError> {
  const RepsInput.pure() : super.pure('');
  const RepsInput.dirty([super.value = '']) : super.dirty();

  @override
  RepsValidationError? validator(String value) {
    if (value.isEmpty) return RepsValidationError.empty;
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) return RepsValidationError.invalid;
    return null;
  }
}

class RestSecondsInput extends FormzInput<String, RestSecondsValidationError> {
  const RestSecondsInput.pure() : super.pure('');
  const RestSecondsInput.dirty([super.value = '']) : super.dirty();

  @override
  RestSecondsValidationError? validator(String value) {
    if (value.isEmpty) return null;
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 0) return RestSecondsValidationError.invalid;
    return null;
  }
}

class RpeInput extends FormzInput<String, RpeValidationError> {
  const RpeInput.pure() : super.pure('');
  const RpeInput.dirty([super.value = '']) : super.dirty();

  @override
  RpeValidationError? validator(String value) {
    if (value.isEmpty) return RpeValidationError.empty;
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0) return RpeValidationError.invalid;
    return null;
  }
}
