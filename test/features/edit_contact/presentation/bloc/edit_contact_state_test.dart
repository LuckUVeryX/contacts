import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/features/edit_contact/presentation/bloc/edit_contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditContactsState', () {
    const mockInitialContact = Contact(
      id: 1,
      firstName: 'firstName1',
      lastName: 'lastName1',
      phoneNumber: 'phoneNumber1',
      emailAddress: 'emailAddress1',
      profileColor: Colors.red,
    );

    EditContactState createState({
      EditContactStatus status = EditContactStatus.initial,
      Contact? initialContact,
      String firstName = '',
      String lastName = '',
      String phoneNumber = '',
      String emailAddress = '',
    }) {
      return EditContactState(
        status: status,
        initialContact: initialContact,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
      );
    }

    test('should support value equality', () {
      expect(createState(), createState());
    });

    test('should have the correct props', () {
      final res = EditContactState(
        status: EditContactStatus.initial,
        initialContact: mockInitialContact,
        firstName: 'first',
        lastName: 'last',
        phoneNumber: '+123 45678',
        emailAddress: 'email',
      );

      final expected = <Object?>[
        EditContactStatus.initial,
        mockInitialContact,
        'first',
        'last',
        '+123 45678',
        'email',
      ];

      expect(res.props, expected);
    });

    test('isNewContact should returns true when a new contact is being created',
        () {
      final res = createState(initialContact: null);

      expect(res.isNewContact, isTrue);
    });

    test(
        'isNewContact should returns false when existing contact is being edited',
        () {
      final res = createState(initialContact: mockInitialContact);

      expect(res.isNewContact, isFalse);
    });

    group('copyWith', () {
      test('should return the same object if no arguments are provided', () {
        final res = createState().copyWith();

        expect(res, createState());
      });

      test(
          'should retain the old value for every parameter if null is provided',
          () {
        final res = createState().copyWith(
          emailAddress: null,
          firstName: null,
          initialContact: null,
          lastName: null,
          phoneNumber: null,
          status: null,
        );

        expect(res, createState());
      });

      test('should replace every non null parameter', () {
        final res = createState().copyWith(
          status: EditContactStatus.loading,
          initialContact: mockInitialContact,
          firstName: '',
          lastName: '',
          emailAddress: '',
          phoneNumber: '',
        );

        expect(
          res,
          createState(
            status: EditContactStatus.loading,
            initialContact: mockInitialContact,
            firstName: '',
            lastName: '',
            emailAddress: '',
            phoneNumber: '',
          ),
        );
      });
    });
  });
}
