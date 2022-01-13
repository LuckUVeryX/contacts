part of 'contacts_list_bloc.dart';

abstract class ContactsListEvent extends Equatable {
  const ContactsListEvent();

  @override
  List<Object?> get props => [];
}

class ContactsListSubscriptionRequested extends ContactsListEvent {}

class ContactsListContactSaved extends ContactsListEvent {
  const ContactsListContactSaved(this.contact);

  final Contact contact;

  @override
  List<Object?> get props => [contact];
}

class ContactsListContactDeleted extends ContactsListEvent {
  const ContactsListContactDeleted(this.contact);

  final Contact contact;

  @override
  List<Object?> get props => [contact];
}

class ContactsListUndoDeletionRequested extends ContactsListEvent {}
