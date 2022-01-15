import 'package:contacts/core/domain/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Contact', () {
    const mockContact = Contact(
      id: 1,
      firstName: 'firstName1',
      lastName: 'lastName1',
      phoneNumber: 'phoneNumber1',
      emailAddress: 'emailAddress1',
      profileColor: Colors.red,
    );

    Contact createContact({
      int id = 1,
      String firstName = '',
      String lastName = '',
      String phoneNumber = '',
      String emailAddress = '',
      Color profileColor = Colors.red,
    }) {
      return Contact(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        profileColor: profileColor,
      );
    }

    test('should support value equality', () {
      expect(createContact(), createContact());
    });

    test('should have the correct props', () {
      expect(mockContact.props, [
        1,
        'firstName1',
        'lastName1',
        'phoneNumber1',
        'emailAddress1',
        Colors.red,
      ]);
    });

    test('should return the correct initials', () {
      expect(mockContact.initals, 'fl');
    });
  });
}
