import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum FirstNameValidationError { invalid }

class FirstName extends FormzInput<String, FirstNameValidationError>
    with EquatableMixin {
  const FirstName.pure([String value = '']) : super.pure(value);
  const FirstName.dirty([String value = '']) : super.dirty(value);

  @override
  FirstNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : FirstNameValidationError.invalid;
  }

  @override
  List<Object?> get props => [value, pure];
}

enum LastNameValidationError { invalid }

class LastName extends FormzInput<String, LastNameValidationError>
    with EquatableMixin {
  const LastName.pure([String value = '']) : super.pure(value);
  const LastName.dirty([String value = '']) : super.dirty(value);

  @override
  LastNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : LastNameValidationError.invalid;
  }

  @override
  List<Object?> get props => [value, pure];
}
