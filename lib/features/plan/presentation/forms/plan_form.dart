import 'package:formz/formz.dart';

enum NameValidationError { empty, tooShort, tooLong }

class Name extends FormzInput<String, NameValidationError> {
  // .pure() indica un campo non ancora toccato dall'utente
  const Name.pure() : super.pure('');
  // .dirty() indica un campo modificato
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    return value.length > 6 ? null : NameValidationError.tooShort;
  }

}