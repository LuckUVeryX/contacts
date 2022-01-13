part of 'edit_contact_bloc.dart';

abstract class EditContactEvent extends Equatable {
  const EditContactEvent();

  @override
  List<Object> get props => [];
}

class EditContactFirstNameChanged extends EditContactEvent {
  const EditContactFirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class EditContactLastNameChanged extends EditContactEvent {
  const EditContactLastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class EditContactPhoneNumberChanged extends EditContactEvent {
  const EditContactPhoneNumberChanged(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class EditContactEmailChanged extends EditContactEvent {
  const EditContactEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class EditContactSubmitted extends EditContactEvent {}
