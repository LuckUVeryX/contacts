import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

class Contact extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final Color profileColor;

  const Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
    required this.profileColor,
  });

  Contact copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? emailAddress,
    Color? profileColor,
  }) {
    return Contact(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      profileColor: profileColor ?? this.profileColor,
    );
  }

  String get initials {
    String first = '';
    String last = '';
    if (firstName.isNotEmpty) {
      first = firstName[0];
    }
    if (lastName.isNotEmpty) {
      last = lastName[0];
    }
    return first + last;
  }

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      phoneNumber,
      emailAddress,
    ];
  }

  @override
  String toString() {
    return 'Contact(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, emailAddress: $emailAddress, profileColor: $profileColor)';
  }
}
