import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/features/contacts_list/presentation/bloc/contacts_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mockContact = Contact(
    id: 1,
    firstName: 'Ryan',
    lastName: 'Yip',
    phoneNumber: '+65 97299957',
    emailAddress: 'ryanyip@example.com',
  );
  final mockContacts = [mockContact];

  ContactsListState createState({
    ContactsListStatus status = ContactsListStatus.initial,
    List<Contact>? contacts,
    Contact? lastDeletedContact,
  }) {
    return ContactsListState(
      status: status,
      contacts: contacts ?? mockContacts,
      lastDeletedContact: lastDeletedContact,
    );
  }

  group('ContactsListState -', () {
    test('should support value equality', () {
      final res = createState();

      expect(res, createState());
    });

    test('should have the correct props', () {
      final res = createState(
        status: ContactsListStatus.loading,
        contacts: mockContacts,
        lastDeletedContact: null,
      );

      expect(
        res.props,
        <Object?>[
          ContactsListStatus.loading,
          mockContacts,
          null,
        ],
      );
    });

    group('copyWith', () {
      test('should return the same object if no arguments are given', () {
        final res = createState();

        expect(res.copyWith(), createState());
      });

      test(
          'should retain the old value for every parameter if null is provided',
          () {
        final res = createState();

        expect(
          res.copyWith(
            contacts: null,
            lastDeletedContact: null,
            status: null,
          ),
          createState(),
        );
      });

      test('should replace every non null parameter', () {
        final res = createState().copyWith(
          contacts: [],
          lastDeletedContact: () => mockContact,
          status: ContactsListStatus.success,
        );

        const expected = ContactsListState(
          contacts: [],
          lastDeletedContact: mockContact,
          status: ContactsListStatus.success,
        );

        expect(res, expected);
      });

      test('should remove lastDeletedContact when null is passed', () {
        var res = createState(lastDeletedContact: mockContact);
        res = res.copyWith(lastDeletedContact: () => null);
        final expected = createState(lastDeletedContact: null);

        expect(res, expected);
      });
    });

    group('the getter contacts', () {
      test('should return a list of sorted contacts sorted by last name', () {
        final mockUnsortedContacts = [
          const Contact(
            id: 1,
            firstName: 'first',
            lastName: 'c',
            phoneNumber: 'phone',
            emailAddress: 'email',
          ),
          const Contact(
            id: 2,
            firstName: 'first',
            lastName: 'b',
            phoneNumber: 'phone',
            emailAddress: 'email',
          ),
          const Contact(
            id: 3,
            firstName: 'first',
            lastName: 'a',
            phoneNumber: 'phone',
            emailAddress: 'email',
          ),
        ];

        final mockSortedContacts = [
          const Contact(
            id: 3,
            firstName: 'first',
            lastName: 'a',
            phoneNumber: 'phone',
            emailAddress: 'email',
          ),
          const Contact(
            id: 2,
            firstName: 'first',
            lastName: 'b',
            phoneNumber: 'phone',
            emailAddress: 'email',
          ),
          const Contact(
            id: 1,
            firstName: 'first',
            lastName: 'c',
            phoneNumber: 'phone',
            emailAddress: 'email',
          ),
        ];
        var res = createState(contacts: mockUnsortedContacts);

        expect(res.contacts, mockSortedContacts);
      });
    });
  });
}
