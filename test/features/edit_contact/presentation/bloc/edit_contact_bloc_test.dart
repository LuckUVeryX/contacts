import 'package:bloc_test/bloc_test.dart';
import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/core/domain/repositories/contacts_repository.dart';
import 'package:contacts/features/edit_contact/presentation/bloc/edit_contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

    group('ructor', () {
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
            bloc.add( const EditContactFirstNameChanged('newFirstName')),
        expect: () =>
            <EditContactState>[EditContactState(firstName: 'newFirstName')],
      );
    });
    group('EditContactLastNameChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits new state with updated lastName',
        build: buildBloc,
        act: (bloc) =>
            bloc.add( const EditContactLastNameChanged('newLastName')),
        expect: () =>
            <EditContactState>[EditContactState(lastName: 'newLastName')],
      );
    });
    group('EditContactPhoneNumberChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits new state with updated phoneNumber',
        build: buildBloc,
        act: (bloc) =>
            bloc.add( const EditContactPhoneNumberChanged('newPhoneNumber')),
        expect: () =>
            <EditContactState>[EditContactState(phoneNumber: 'newPhoneNumber')],
      );
    });
    group('EditContactEmailChanged', () {
      blocTest<EditContactBloc, EditContactState>(
        'emits new state with updated email',
        build: buildBloc,
        act: (bloc) => bloc.add( const EditContactEmailChanged('newEmail')),
        expect: () =>
            <EditContactState>[EditContactState(emailAddress: 'newEmail')],
      );
    });

    group('EditContactSubmitted', () {
      blocTest<EditContactBloc, EditContactState>(
        'should save contact to repository if no initial contact is provided',
        build: buildBloc,
        seed: () =>  EditContactState(
          firstName: 'firstName',
          lastName: 'lastName',
          emailAddress: 'email',
          phoneNumber: '+123456789',
        ),
        act: (bloc) => bloc.add(EditContactSubmitted()),
        expect: () => <EditContactState>[
           EditContactState(
            status: EditContactStatus.loading,
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: 'email',
            phoneNumber: '+123456789',
          ),
           EditContactState(
            status: EditContactStatus.done,
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: 'email',
            phoneNumber: '+123456789',
          ),
        ],
        verify: (bloc) => verify(
          repository.saveContact(
             const Contact(
              id: -1,
              firstName: 'firstName',
              lastName: 'lastName',
              phoneNumber: '+123456789',
              emailAddress: 'email',
              profileColor: Colors.red,
            ),
          ),
        ),
      );
      blocTest<EditContactBloc, EditContactState>(
        'should save contact to repository if initial contact is provided',
        build: buildBloc,
        seed: () =>  EditContactState(
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
          emailAddress: 'email',
          phoneNumber: '+123456789',
        ),
        act: (bloc) => bloc.add(EditContactSubmitted()),
        expect: () => <EditContactState>[
           EditContactState(
            status: EditContactStatus.loading,
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
            emailAddress: 'email',
            phoneNumber: '+123456789',
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
            status: EditContactStatus.done,
            firstName: 'firstName',
            lastName: 'lastName',
            emailAddress: 'email',
            phoneNumber: '+123456789',
          ),
        ],
        verify: (bloc) => verify(
          repository.saveContact(
             const Contact(
              id: -1,
              firstName: 'firstName',
              lastName: 'lastName',
              phoneNumber: '+123456789',
              emailAddress: 'email',
              profileColor: Colors.red,
            ),
          ),
        ),
      );
    });
  });
}
