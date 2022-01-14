import 'package:contacts/core/data/datasources/contacts_local_datasource.dart';
import 'package:contacts/core/data/models/raw_contacts_model.dart';
import 'package:contacts/core/data/repositories/contacts_repostory_impl.dart';
import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/core/errors/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contacts_repostory_impl_test.mocks.dart';

@GenerateMocks([ContactsLocalDataSource])
void main() {
  MockContactsLocalDataSource mockDataSource = MockContactsLocalDataSource();

  const tRawContact = RawContact(
    id: 1,
    name: 'Ryan Yip',
    email: 'ryanyip@example.com',
    phone: '+65 97299957',
  );

  void setUpMockDataSourceEmptyList() {
    when(mockDataSource.fetchContacts()).thenAnswer(
      (_) async => const RawContacts(contacts: []),
    );
  }

  void setUpMockDataSourcePopulatedList() {
    when(mockDataSource.fetchContacts()).thenAnswer(
      (_) async => const RawContacts(contacts: [tRawContact]),
    );
  }

  group('ContactsRepository -', () {
    group('contacts', () {
      late ContactsRepository repository;

      setUp(() {
        repository = ContactsRepository(mockDataSource);
      });
      test(
          'should return a stream containing an empty list of contacts when initialised',
          () async {
        setUpMockDataSourceEmptyList();

        final res = repository.contacts;

        expectLater(res, emits([]));
      });

      test(
          'should return the parsed contacts fetched from local data source when init function is called',
          () async {
        setUpMockDataSourcePopulatedList();
        const expected = [
          Contact(
            id: 1,
            firstName: 'Ryan',
            lastName: 'Yip',
            phoneNumber: '+65 97299957',
            emailAddress: 'ryanyip@example.com',
            profileColor: Colors.red,
          )
        ];

        await repository.init();
        final res = repository.contacts;

        expectLater(res, emits(expected));
      });
    });

    group('deleteContact', () {
      late ContactsRepository repository;
      late Stream<List<Contact>> res;

      setUp(() async {
        setUpMockDataSourcePopulatedList();
        repository = ContactsRepository(mockDataSource);
        res = repository.contacts;
        await repository.init();
      });

      test('should delete contact when contact with valid id is given', () {
        repository.deleteContact(1);
        expectLater(res, emits([]));
      });
      test(
          'should throw ContactNotFoundException when contact with invalid id is given',
          () {
        expect(
          () => repository.deleteContact(1123123),
          throwsA(isA<ContactNotFoundException>()),
        );
      });
    });

    group('saveContact', () {
      late ContactsRepository repository;
      late Stream<List<Contact>> res;

      setUp(() async {
        setUpMockDataSourcePopulatedList();
        repository = ContactsRepository(mockDataSource);
        res = repository.contacts;
        await repository.init();
      });

      test(
        'should add new contact if id doesnt exist current lists of contacts',
        () async {
          const tContact = Contact(
            id: 123,
            firstName: 'firstname',
            lastName: 'lastname',
            phoneNumber: '123456789',
            emailAddress: 'emailaddress@email.com',
            profileColor: Colors.red,
          );

          const initialContact = Contact(
            id: 1,
            firstName: 'Ryan',
            lastName: 'Yip',
            phoneNumber: '+65 97299957',
            emailAddress: 'ryanyip@example.com',
            profileColor: Colors.red,
          );

          repository.saveContact(tContact);

          expectLater(res, emits([initialContact, tContact]));
        },
      );
      test(
        'should edit existing contact if id doesnt exist current lists of contacts',
        () async {
          const newContact = Contact(
            id: 1,
            firstName: 'firstname',
            lastName: 'lastname',
            phoneNumber: '123456789',
            emailAddress: 'emailaddress@email.com',
            profileColor: Colors.red,
          );

          repository.saveContact(newContact);

          expectLater(res, emits([newContact]));
        },
      );
    });
  });
}
