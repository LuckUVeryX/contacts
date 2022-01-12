import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;

  const Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
  });

  Contact copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? emailAddress,
  }) {
    return Contact(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
    );
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
    return 'Contact(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, emailAddress: $emailAddress)';
  }
}
