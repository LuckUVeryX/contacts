import 'package:contacts/features/edit_contact/presentation/bloc/edit_contact_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditContactsEvent', () {
    group('EditContactFirstNameEvent', () {
      test('should support value equality', () {
        expect(
          const EditContactFirstNameEvent('firstName'),
          const EditContactFirstNameEvent('firstName'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactFirstNameEvent('firstName').props,
          <Object>['firstName'],
        );
      });
    });
    group('EditContactLastNameEvent', () {
      test('should support value equality', () {
        expect(
          const EditContactLastNameEvent('lastName'),
          const EditContactLastNameEvent('lastName'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactLastNameEvent('lastName').props,
          <Object>['lastName'],
        );
      });
    });
    group('EditContactPhoneNumberEvent', () {
      test('should support value equality', () {
        expect(
          const EditContactPhoneNumberEvent('phoneNum'),
          const EditContactPhoneNumberEvent('phoneNum'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactPhoneNumberEvent('phoneNum').props,
          <Object>['phoneNum'],
        );
      });
    });
    group('EditContactEmailEvent', () {
      test('should support value equality', () {
        expect(
          const EditContactEmailEvent('email'),
          const EditContactEmailEvent('email'),
        );
      });

      test('should have the correct props', () {
        expect(
          const EditContactEmailEvent('email').props,
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
