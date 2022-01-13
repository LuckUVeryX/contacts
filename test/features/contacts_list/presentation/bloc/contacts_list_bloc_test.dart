import 'package:bloc_test/bloc_test.dart';
import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/core/domain/repositories/contacts_repository.dart';
import 'package:contacts/features/contacts_list/presentation/bloc/contacts_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../edit_contact/presentation/bloc/edit_contact_bloc_test.mocks.dart';

@GenerateMocks([IContactsRepository])
void main() {
  final mockContacts = [
    const Contact(
      id: 1,
      firstName: 'firstName 1',
      lastName: 'lastName 1',
      phoneNumber: 'phone 1',
      emailAddress: 'email 1',
    ),
    const Contact(
      id: 2,
      firstName: 'firstName 2',
      lastName: 'lastName 2',
      phoneNumber: 'phone 2',
      emailAddress: 'email 2',
    ),
    const Contact(
      id: 3,
      firstName: 'firstName 3',
      lastName: 'lastName 3',
      phoneNumber: 'phone 3',
      emailAddress: 'email 3',
    ),
  ];

  group('ContactsListBloc -', () {
    late IContactsRepository repository;

    setUp(() {
      repository = MockIContactsRepository();
      when(repository.contacts).thenAnswer((_) => Stream.value(mockContacts));
    });

    ContactsListBloc buildBloc() {
      return ContactsListBloc(repository);
    }

    group('constructor', () {
      test('should work properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has correct initial state', () {
        expect(buildBloc().state, const ContactsListState());
      });
    });

    group('ContactsListSubscriptionRequested', () {
      blocTest<ContactsListBloc, ContactsListState>(
        'should start listening to repository contacts stream.',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(ContactsListSubscriptionRequested()),
        verify: (bloc) => verify(repository.contacts),
      );

      blocTest<ContactsListBloc, ContactsListState>(
        'emits state with update status and contacts when repository contacts stream emits new contacts.',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(ContactsListSubscriptionRequested()),
        expect: () => <ContactsListState>[
          const ContactsListState(
            status: ContactsListStatus.loading,
          ),
          ContactsListState(
            status: ContactsListStatus.success,
            contacts: mockContacts,
          ),
        ],
      );

      blocTest<ContactsListBloc, ContactsListState>(
        'emits state with failure status when repository contacts stream emits error',
        setUp: () {
          when(repository.contacts)
              .thenAnswer((realInvocation) => Stream.error(Exception));
        },
        build: () => buildBloc(),
        act: (bloc) => bloc.add(ContactsListSubscriptionRequested()),
        expect: () => <ContactsListState>[
          const ContactsListState(status: ContactsListStatus.loading),
          const ContactsListState(status: ContactsListStatus.failure),
        ],
      );
    });

    group('ContactsListContactSaved', () {
      blocTest<ContactsListBloc, ContactsListState>(
        'should call repository saveContact with the correct contact',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(ContactsListContactSaved(mockContacts.first)),
        verify: (bloc) => verify(repository.saveContact(mockContacts.first)),
      );
    });

    group('ContactsListContactDeleted', () {
      blocTest<ContactsListBloc, ContactsListState>(
        'should call repository deleteContact with the correct contact id',
        build: () => buildBloc(),
        act: (bloc) => bloc.add(ContactsListContactDeleted(mockContacts.first)),
        verify: (bloc) =>
            verify(repository.deleteContact(mockContacts.first.id)),
      );
    });

    group('ContactsListUndoDeletionRequested', () {
      blocTest<ContactsListBloc, ContactsListState>(
        'restores last deleted contact and clears lastDeletedContact field',
        build: () => buildBloc(),
        seed: () => ContactsListState(lastDeletedContact: mockContacts.first),
        act: (bloc) => bloc.add(ContactsListUndoDeletionRequested()),
        expect: () => const <ContactsListState>[ContactsListState()],
        verify: (bloc) => verify(repository.saveContact(mockContacts.first)),
      );
    });
  });
}
