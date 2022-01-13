part of 'edit_contact_bloc.dart';

abstract class EditContactEvent extends Equatable {
  const EditContactEvent();

  @override
  List<Object> get props => [];
}

class EditContactFirstNameEvent extends EditContactEvent {
  const EditContactFirstNameEvent(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class EditContactLastNameEvent extends EditContactEvent {
  const EditContactLastNameEvent(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class EditContactPhoneNumberEvent extends EditContactEvent {
  const EditContactPhoneNumberEvent(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class EditContactEmailEvent extends EditContactEvent {
  const EditContactEmailEvent(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class EditContactSubmitted extends EditContactEvent {}
