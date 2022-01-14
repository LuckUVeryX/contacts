import 'package:contacts/core/domain/entities/contact.dart';
import 'package:contacts/features/contacts_list/presentation/bloc/contacts_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContactsListEvent -', () {
    const mockContact = Contact(
      id: 1,
      firstName: 'Ryan',
      lastName: 'Yip',
      phoneNumber: '+65 97299957',
      emailAddress: 'ryanyip@example.com',
        profileColor: Colors.red,
    );

    group('ContactsListSubscriptionRequested', () {
      test('should support value equality', () {
        final res = ContactsListSubscriptionRequested();

        expect(res, ContactsListSubscriptionRequested());
      });

      test('should have the correct props', () {
        expect(ContactsListSubscriptionRequested().props, <Object>[]);
      });
    });

    group('ContactsListContactSaved', () {
      test('should support value equality', () {
        const res = ContactsListContactSaved(mockContact);

        expect(res, const ContactsListContactSaved(mockContact));
      });

      test('should have correct props', () {
        final res = const ContactsListContactSaved(mockContact).props;

        expect(res, <Object?>[mockContact]);
      });
    });
    group('ContactsListContactDeleted', () {
      test('should support value equality', () {
        const res = ContactsListContactDeleted(mockContact);

        expect(res, const ContactsListContactDeleted(mockContact));
      });

      test('should have correct props', () {
        final res = const ContactsListContactDeleted(mockContact).props;

        expect(res, <Object?>[mockContact]);
      });
    });

    group('ContactsListUndoDeletionRequested', () {
      test('should support value equality', () {
        final res = ContactsListUndoDeletionRequested();

        expect(res, ContactsListUndoDeletionRequested());
      });

      test('should have the correct props', () {
        expect(ContactsListUndoDeletionRequested().props, <Object>[]);
      });
    });
  });
}
