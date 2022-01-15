part of 'edit_contact_bloc.dart';

enum EditContactStatus { initial, loading, done }

class EditContactState extends Equatable {
  EditContactState({
    this.status = EditContactStatus.initial,
    this.formStatus = FormzStatus.pure,
    this.initialContact,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.emailAddress = const Email.pure(),
    Color? profileColor,
  }) : profileColor = profileColor ??
            initialContact?.profileColor ??
            PurpleShades.randomColor;

  final EditContactStatus status;
  final FormzStatus formStatus;
  final Contact? initialContact;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Email emailAddress;
  final Color profileColor;

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
      formStatus,
      initialContact,
      firstName,
      lastName,
      phoneNumber,
      emailAddress,
    ];
  }

  EditContactState copyWith({
    EditContactStatus? status,
    FormzStatus? formStatus,
    Contact? initialContact,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    Email? emailAddress,
    Color? profileColor,
  }) {
    return EditContactState(
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      initialContact: initialContact ?? this.initialContact,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      profileColor: profileColor ?? this.profileColor,
    );
  }

  @override
  String toString() {
    return 'EditContactState(status: $status, formStatus: $formStatus, initialContact: $initialContact, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, emailAddress: $emailAddress, profileColor: $profileColor)';
  }
}
