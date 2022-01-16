import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/features/edit_contact/domain/entities/email.dart';
import 'package:contacts/features/edit_contact/domain/entities/names.dart';
import 'package:contacts/features/edit_contact/domain/entities/phone_number.dart';
import 'package:contacts/features/edit_contact/presentation/bloc/edit_contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

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
      Contact? initialContact,
      FirstName firstName = const FirstName.pure(),
      LastName lastName = const LastName.pure(),
      PhoneNumber phoneNumber = const PhoneNumber.pure(),
      Email emailAddress = const Email.pure(),
      FormzStatus formStatus = FormzStatus.pure,
    }) {
      return EditContactState(
        initialContact: initialContact,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        formStatus: formStatus,
      );
    }

    test('should support value equality', () {
      expect(createState(), createState());
    });

    test('should have the correct props', () {
      final res = EditContactState(
        formStatus: FormzStatus.pure,
        initialContact: mockInitialContact,
        firstName: const FirstName.pure('first'),
        lastName: const LastName.pure('last'),
        phoneNumber: const PhoneNumber.pure('+123 45678'),
        emailAddress: const Email.pure('email'),
      );

      final expected = <Object?>[
        FormzStatus.pure,
        mockInitialContact,
        const FirstName.pure('first'),
        const LastName.pure('last'),
        const PhoneNumber.pure('+123 45678'),
        const Email.pure('email'),
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
          formStatus: null,
        );

        expect(res, createState());
      });

      test('should replace every non null parameter', () {
        final res = createState().copyWith(
          initialContact: mockInitialContact,
          firstName: const FirstName.pure(),
          lastName: const LastName.pure(),
          emailAddress: const Email.pure(),
          phoneNumber: const PhoneNumber.pure(),
        );

        expect(
          res,
          createState(
            initialContact: mockInitialContact,
            firstName: const FirstName.pure(),
            lastName: const LastName.pure(),
            emailAddress: const Email.pure(),
            phoneNumber: const PhoneNumber.pure(),
          ),
        );
      });
    });
  });
}
