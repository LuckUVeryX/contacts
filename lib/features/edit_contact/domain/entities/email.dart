import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError>
    with EquatableMixin {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return EmailValidator.validate(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }

  @override
  List<Object?> get props => [value, pure];
}
