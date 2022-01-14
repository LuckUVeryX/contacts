part of 'contacts_list_bloc.dart';

enum ContactsListStatus { initial, loading, success, failure }

/// Keeps track of list of `contacts`, the `lastDeletedContact`, and the `status` of the contacts list page.
class ContactsListState extends Equatable {
  const ContactsListState({
    this.status = ContactsListStatus.initial,
    List<Contact> contacts = const [],
    this.lastDeletedContact,
  }) : _contacts = contacts;

  final ContactsListStatus status;
  final List<Contact> _contacts;
  final Contact? lastDeletedContact;

  List<Contact> get contacts => List.unmodifiable(List<Contact>.from(_contacts)
    ..sort((a, b) => a.lastName.compareTo(b.lastName)));

  @override
  List<Object?> get props => [status, _contacts, lastDeletedContact];

  ContactsListState copyWith({
    ContactsListStatus? status,
    List<Contact>? contacts,
    Contact? Function()? lastDeletedContact,
  }) {
    return ContactsListState(
      status: status ?? this.status,
      contacts: contacts ?? _contacts,
      lastDeletedContact: lastDeletedContact != null
          ? lastDeletedContact()
          : this.lastDeletedContact,
    );
  }
}
