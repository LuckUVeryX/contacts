import 'package:bloc_test/bloc_test.dart';
import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/core/domain/repositories/contacts_repository.dart';
import 'package:contacts/features/edit_contact/domain/entities/email.dart';
import 'package:contacts/features/edit_contact/domain/entities/phone_number.dart';
import 'package:contacts/features/edit_contact/presentation/bloc/edit_contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../contacts_list/presentation/bloc/contacts_list_bloc_test.mocks.dart';

@GenerateMocks([IContactsRepository])
void main() {
  group('EditContactBloc-', () {
    late IContactsRepository repository;

    setUp(() {
      repository = MockIContactsRepository();
    });

    EditContactBloc buildBloc() {
      return EditContactBloc(repository: repository, initialContact: null);
    }

    group('constructor', () {
      test('should work properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('should have the correct initial state', () {
        expect(buildBloc().state, EditContactState());
      });
    });

    group('EditContactFirstNameChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits new state with updated firstName',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const EditContactFirstNameChanged('newFirstName')),
        expect: () =>
            <EditContactState>[EditContactState(firstName: 'newFirstName')],
      );
    });
    group('EditContactLastNameChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits new state with updated lastName',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const EditContactLastNameChanged('newLastName')),
        expect: () =>
            <EditContactState>[EditContactState(lastName: 'newLastName')],
      );
    });
    group('EditContactPhoneNumberChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits FormzStatus.valid with updated phoneNumber if valid phone number is given',
        build: buildBloc,
        seed: () => EditContactState(
          formStatus: FormzStatus.valid,
          emailAddress: const Email.pure('valid@email.com'),
        ),
        act: (bloc) =>
            bloc.add(const EditContactPhoneNumberChanged('97299957')),
        expect: () => <EditContactState>[
          EditContactState(
            phoneNumber: const PhoneNumber.dirty('97299957'),
            emailAddress: const Email.pure('valid@email.com'),
            formStatus: FormzStatus.valid,
          )
        ],
      );
      blocTest<EditContactBloc, EditContactState>(
        'emits new state with updated phoneNumber if invalid phone number is given',
        build: buildBloc,
        seed: () => EditContactState(
          formStatus: FormzStatus.valid,
          emailAddress: const Email.pure('valid@email.com'),
        ),
        act: (bloc) => bloc.add(const EditContactPhoneNumberChanged('invalid')),
        expect: () => <EditContactState>[
          EditContactState(
            phoneNumber: const PhoneNumber.pure('invalid'),
            emailAddress: const Email.pure('valid@email.com'),
            formStatus: FormzStatus.invalid,
          )
        ],
      );
    });
    group('EditContactEmailChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits FormzStatus.valid state with updated email if valid email is given',
        build: buildBloc,
        seed: () => EditContactState(
          formStatus: FormzStatus.valid,
          phoneNumber: const PhoneNumber.pure('97299957'),
        ),
        act: (bloc) =>
            bloc.add(const EditContactEmailChanged('valid@example.com')),
        expect: () {
          return <EditContactState>[
            EditContactState(
              emailAddress: const Email.dirty('valid@example.com'),
              phoneNumber: const PhoneNumber.pure('97299957'),
              formStatus: FormzStatus.valid,
            )
          ];
        },
      );
      blocTest<EditContactBloc, EditContactState>(
        'emits FormzStatus.invalid state with updated email if invalid email is given',
        build: buildBloc,
        seed: () => EditContactState(
          formStatus: FormzStatus.valid,
          phoneNumber: const PhoneNumber.pure('97299957'),
        ),
        act: (bloc) =>
            bloc.add(const EditContactEmailChanged('invalid@example')),
        expect: () {
          return <EditContactState>[
            EditContactState(
              emailAddress: const Email.pure('invalid@example'),
              formStatus: FormzStatus.invalid,
              phoneNumber: const PhoneNumber.pure('97299957'),
            )
          ];
        },
      );
    });

    group('EditContactSubmitted', () {
      blocTest<EditContactBloc, EditContactState>(
        'should save contact to repository if no initial contact is provided',
        build: buildBloc,
        seed: () => EditContactState(
          firstName: 'firstName',
          lastName: 'lastName',
          emailAddress: const Email.pure('valid@email.com'),
          phoneNumber: const PhoneNumber.pure('+123456789'),
        ),
        act: (bloc) => bloc.add(EditContactSubmitted()),
        expect: () => <EditContactState>[
          EditContactState(
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: const Email.dirty('valid@email.com'),
            phoneNumber: const PhoneNumber.dirty('+123456789'),
            formStatus: FormzStatus.valid,
          ),
          EditContactState(
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: const Email.dirty('valid@email.com'),
            phoneNumber: const PhoneNumber.dirty('+123456789'),
            formStatus: FormzStatus.submissionInProgress,
          ),
          EditContactState(
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: const Email.dirty('valid@email.com'),
            phoneNumber: const PhoneNumber.dirty('+123456789'),
            formStatus: FormzStatus.submissionSuccess,
          ),
        ],
        verify: (bloc) => verify(
          repository.saveContact(
            const Contact(
              id: -1,
              firstName: 'firstName',
              lastName: 'lastName',
              phoneNumber: '+123456789',
              emailAddress: 'valid@email.com',
              profileColor: Colors.red,
            ),
          ),
        ),
      );
      blocTest<EditContactBloc, EditContactState>(
        'should save contact to repository if initial contact is provided',
        build: buildBloc,
        seed: () => EditContactState(
          initialContact: const Contact(
            id: -1,
            firstName: 'initFirstName',
            lastName: 'initLastName',
            phoneNumber: 'initPhone',
            emailAddress: 'initEmail',
            profileColor: Colors.red,
          ),
          firstName: 'firstName',
          lastName: 'lastName',
          emailAddress: const Email.pure('valid@email.com'),
          phoneNumber: const PhoneNumber.pure('+123456789'),
        ),
        act: (bloc) => bloc.add(EditContactSubmitted()),
        expect: () => <EditContactState>[
          EditContactState(
            initialContact: const Contact(
              id: -1,
              firstName: 'initFirstName',
              lastName: 'initLastName',
              phoneNumber: 'initPhone',
              emailAddress: 'initEmail',
              profileColor: Colors.red,
            ),
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: const Email.dirty('valid@email.com'),
            phoneNumber: const PhoneNumber.dirty('+123456789'),
            formStatus: FormzStatus.valid,
          ),
          EditContactState(
            initialContact: const Contact(
              id: -1,
              firstName: 'initFirstName',
              lastName: 'initLastName',
              phoneNumber: 'initPhone',
              emailAddress: 'initEmail',
              profileColor: Colors.red,
            ),
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: const Email.dirty('valid@email.com'),
            phoneNumber: const PhoneNumber.dirty('+123456789'),
            formStatus: FormzStatus.submissionInProgress,
          ),
          EditContactState(
            initialContact: const Contact(
              id: -1,
              firstName: 'initFirstName',
              lastName: 'initLastName',
              phoneNumber: 'initPhone',
              emailAddress: 'initEmail',
              profileColor: Colors.red,
            ),
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: const Email.dirty('valid@email.com'),
            phoneNumber: const PhoneNumber.dirty('+123456789'),
            formStatus: FormzStatus.submissionSuccess,
          ),
        ],
        verify: (bloc) => verify(
          repository.saveContact(
            const Contact(
              id: -1,
              firstName: 'firstName',
              lastName: 'lastName',
              phoneNumber: '+123456789',
              emailAddress: 'valid@email.com',
              profileColor: Colors.red,
            ),
          ),
        ),
      );
    });
  });
}
