import 'package:contacts/features/edit_contact/presentation/bloc/edit_contact_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditContactsEvent', () {
    group('EditContactFirstNameChanged', () {
      test('should support value equality', () {
        expect(
          const EditContactFirstNameChanged('firstName'),
          const EditContactFirstNameChanged('firstName'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactFirstNameChanged('firstName').props,
          <Object>['firstName'],
        );
      });
    });
    group('EditContactLastNameChanged', () {
      test('should support value equality', () {
        expect(
          const EditContactLastNameChanged('lastName'),
          const EditContactLastNameChanged('lastName'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactLastNameChanged('lastName').props,
          <Object>['lastName'],
        );
      });
    });
    group('EditContactPhoneNumberChanged', () {
      test('should support value equality', () {
        expect(
          const EditContactPhoneNumberChanged('phoneNum'),
          const EditContactPhoneNumberChanged('phoneNum'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactPhoneNumberChanged('phoneNum').props,
          <Object>['phoneNum'],
        );
      });
    });
    group('EditContactEmailChanged', () {
      test('should support value equality', () {
        expect(
          const EditContactEmailChanged('email'),
          const EditContactEmailChanged('email'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactEmailChanged('email').props,
          <Object>['email'],
        );
      });
    });
    group('EditContactSubmitted', () {
      test('should support value equality', () {
        expect(
          EditContactSubmitted(),
          EditContactSubmitted(),
        );
      });

      test('should have the correct props', () {
        expect(
          EditContactSubmitted().props,
          <Object>[],
        );
      });
    });
  });
}
