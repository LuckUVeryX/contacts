part of 'edit_contact_bloc.dart';

enum EditContactStatus { initial, loading, done }

class EditContactState extends Equatable {
  const EditContactState({
    this.status = EditContactStatus.initial,
    this.initialContact,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.emailAddress = '',
  });

  final EditContactStatus status;
  final Contact? initialContact;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;

  bool get isNewContact => initialContact == null;

  String get initials {
    String first = '';
    String last = '';
    if (firstName.isNotEmpty) {
      first = firstName[0];
    }
    if (lastName.isNotEmpty) {
      last = lastName[0];
    }
    return '$first$last';
  }

  @override
  List<Object?> get props {
    return [
      status,
      initialContact,
      firstName,
      lastName,
      phoneNumber,
      emailAddress,
    ];
  }

  EditContactState copyWith({
    EditContactStatus? status,
    Contact? initialContact,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? emailAddress,
  }) {
    return EditContactState(
      status: status ?? this.status,
      initialContact: initialContact ?? this.initialContact,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }
}
