import 'package:formz/formz.dart';

enum NameValidationError { empty, tooShort, tooLong }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    return value.length > 6 ? null : NameValidationError.tooShort;
  }
}
