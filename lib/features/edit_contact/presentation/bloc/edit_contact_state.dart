part of 'edit_contact_bloc.dart';

class EditContactState extends Equatable {
  EditContactState({
    this.formStatus = FormzStatus.pure,
    this.initialContact,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.emailAddress = const Email.pure(),
    Color? profileColor,
  }) : profileColor = profileColor ??
            initialContact?.profileColor ??
            PurpleShades.randomColor;

  final FormzStatus formStatus;
  final Contact? initialContact;
  final FirstName firstName;
  final LastName lastName;
  final PhoneNumber phoneNumber;
  final Email emailAddress;
  final Color profileColor;

  bool get isNewContact => initialContact == null;

  String get initials {
    String first = '';
    String last = '';
    if (firstName.value.isNotEmpty) {
      first = firstName.value[0];
    }
    if (lastName.value.isNotEmpty) {
      last = lastName.value[0];
    }
    return '$first$last';
  }

  @override
  List<Object?> get props {
    return [
      formStatus,
      initialContact,
      firstName,
      lastName,
      phoneNumber,
      emailAddress,
    ];
  }

  EditContactState copyWith({
    FormzStatus? formStatus,
    Contact? initialContact,
    FirstName? firstName,
    LastName? lastName,
    PhoneNumber? phoneNumber,
    Email? emailAddress,
    Color? profileColor,
  }) {
    return EditContactState(
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
    return 'EditContactState(formStatus: $formStatus, initialContact: $initialContact, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, emailAddress: $emailAddress, profileColor: $profileColor)';
  }
}
