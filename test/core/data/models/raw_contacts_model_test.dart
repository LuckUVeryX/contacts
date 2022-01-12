import 'dart:convert';

import 'package:contacts/core/data/models/raw_contacts_model.dart';
import 'package:contacts/core/domain/entities/contact.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tRawContact = RawContact(
    id: 1,
    name: 'Ryan Yip',
    email: 'ryanyip@example.com',
    phone: '+65 97299957',
  );
  group('RawContact -', () {
    test('fromJson should return a valid model from contact JSON', () {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('contact.json'));
      final result = RawContact.fromJson(jsonMap);

      expect(result, tRawContact);
    });
  });

  group('RawContacts -', () {
    const tRawContact2 = RawContact(
        id: 2,
        name: 'Knapp Berry',
        email: 'knappberry@unq.com',
        phone: '+1 (951) 472-2967');
    const tRawContacts = RawContacts(contacts: [tRawContact, tRawContact2]);
    test('fromJson should return a valid model from contacts JSON', () {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('contacts.json'));
      final result = RawContacts.fromJson(jsonMap);

      expect(result, tRawContacts);
    });

    test('the getter contactsList should parse and return a list of Contacts',
        () {
      final expected = <Contact>[
        const Contact(
          id: 1,
          firstName: 'Ryan',
          lastName: 'Yip',
          phoneNumber: '+65 97299957',
          emailAddress: 'ryanyip@example.com',
        ),
        const Contact(
          id: 2,
          firstName: 'Knapp',
          lastName: 'Berry',
          phoneNumber: '+1 (951) 472-2967',
          emailAddress: 'knappberry@unq.com',
        ),
      ];

      final Map<String, dynamic> jsonMap = jsonDecode(fixture('contacts.json'));
      final result = RawContacts.fromJson(jsonMap);

      expect(result.contactsList, expected);
    });
  });
}
